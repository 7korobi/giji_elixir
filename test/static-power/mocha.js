(function() {
  var chomp_obj;

  require("require-yaml");

  global.assert = require("power-assert");

  chomp_obj = function(base, obj, a, b) {
    var bb, i, idx, key, len;
    if (!a) {
      return;
    }
    switch (b != null ? b.constructor : void 0) {
      case Object:
        obj[base] = {};
        for (key in b) {
          bb = b[key];
          if (a) {
            chomp_obj(key, obj[base], a[key], bb);
          }
        }
        break;
      case Array:
        obj[base] = [];
        for (idx = i = 0, len = b.length; i < len; idx = ++i) {
          bb = b[idx];
          if (a) {
            chomp_obj(idx, obj[base], a[idx], bb);
          }
        }
        break;
      default:
        obj[base] = a;
    }
    return obj;
  };

  global.assert_only = function(val, expect) {
    var value;
    value = chomp_obj("value", {}, val, expect).value;
    return assert.deepEqual(value, expect);
  };

  global.target = function(path) {
    return require("../../web/static/js/" + path);
  };

}).call(this);

(function() {
  var Collection, Model, Query, Rule, ref;

  ref = require("memory-record"), Collection = ref.Collection, Model = ref.Model, Query = ref.Query, Rule = ref.Rule;

  target("models/chr.coffee");

  describe("Query.faces", function() {
    it("bye jelemy", function() {
      return assert(Query.faces.find("c06") === void 0);
    });
    return it("symon", assert.deepEqual(Query.faces.find("c99").chr_jobs.list[0], Query.chr_jobs.find("ririnra_c99")), assert.deepEqual(Query.faces.find("c99").chr_jobs.list[1], Query.chr_jobs.find("animal_c99")));
  });

  describe("Query.chr_jobs", function() {
    it("order", function() {
      assert(Query.chr_jobs.face("c10").pluck("chr_set_idx" === [0, 2, 7, 8]));
      return assert(Query.chr_jobs.face("c83").pluck("chr_set_idx" === [0, 4, 7, 8]));
    });
    it("zoy", assert(Query.chr_jobs.face("c10").list[0], Query.chr_jobs.find("ririnra_c10")), assert(Query.chr_jobs.face("c10").list[1], Query.chr_jobs.find("time_c10")));
    return it("iris", assert(Query.chr_jobs.face("c83").list[0], Query.chr_jobs.find("ririnra_c83")), assert(Query.chr_jobs.face("c83").list[1], Query.chr_jobs.find("mad_c83")));
  });

}).call(this);

(function() {
  var Collection, InputTie, Model, Query, Rule, _, component, deploy, m, ref, ref1, state,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  _ = require("lodash");

  m = require("mithril");

  ref = require("memory-record"), Collection = ref.Collection, Model = ref.Model, Query = ref.Query, Rule = ref.Rule;

  ref1 = require("mithril-tie"), InputTie = ref1.InputTie, deploy = ref1.deploy;

  deploy({
    window: {
      scrollX: 0,
      scrollY: 0,
      devicePixelRatio: 2
    }
  });

  InputTie.type.icon = (function(superClass) {
    var bigicon, menuicon, tags;

    extend(icon, superClass);

    function icon() {
      return icon.__super__.constructor.apply(this, arguments);
    }

    icon.prototype.option_default = {
      className: "",
      label: "",
      "data-tooltip": "選択しない"
    };

    icon.prototype.option = function(value) {
      var hash, ref2, ref3, ref4;
      hash = (ref2 = (ref3 = this.options.hash) != null ? ref3 : this.options) != null ? ref2 : {};
      return (ref4 = hash[value]) != null ? ref4 : this.option_default;
    };

    icon.prototype["with"] = function(value, mode) {
      var bool;
      bool = this.__value === value;
      switch (mode) {
        case bool:
          return this._with[value]();
        case !bool:
          return null;
        default:
          this._with = {};
          return this._with[value] = mode;
      }
    };

    icon.prototype.item = function(value, m_attr) {
      var ma, option, tag;
      if (m_attr == null) {
        m_attr = {};
      }
      option = this.option(value);
      tag = m_attr.tag || "menuicon";
      ma = this._attr(this.attr, m_attr, option, {
        className: [this.attr.className, m_attr.className, option.className].join(" "),
        selected: value === this.__value,
        value: value
      });
      return tags[tag](value, ma, option);
    };

    menuicon = function(id, attr, arg) {
      var badge, icon, ref2;
      icon = (ref2 = arg.icon) != null ? ref2 : id, badge = arg.badge;
      return m("a.menuicon", attr, m("span.icon-" + icon), badge ? m(".emboss.pull-right", badge()) : void 0);
    };

    bigicon = function(id, attr, arg) {
      var badge, icon, ref2;
      icon = (ref2 = arg.icon) != null ? ref2 : id, badge = arg.badge;
      return m("section", attr, m(".bigicon", m("span.icon-" + icon)), badge ? m(".badge.pull-right", badge()) : void 0);
    };

    tags = {
      menuicon: menuicon,
      bigicon: bigicon
    };

    return icon;

  })(InputTie.type.icon);

  state = {};

  component = {
    controller: function() {
      this.params = {};
      this.tie = InputTie.form(this.params, []);
      this.tie.stay = function(id, value) {
        return state.stay = value;
      };
      this.tie.change = function(id, value, old) {
        return state.change = value;
      };
      this.tie.action = function() {
        return state.action = true;
      };
      this.tie.draws(function() {});
      this.bundles = [
        this.tie.bundle({
          _id: "icon",
          attr: {
            type: "icon"
          },
          name: "アイコン",
          current: null,
          options: Query.menus.hash,
          option_default: {
            label: "icon default"
          }
        })
      ];
    },
    view: function(arg) {
      var _id, icons, tie;
      tie = arg.tie;
      icons = Query.menus.show("menu,home", "book", "normal");
      tie.draw();
      return m(".menus", (function() {
        var i, len, ref2, results;
        ref2 = icons.list;
        results = [];
        for (i = 0, len = ref2.length; i < len; i++) {
          _id = ref2[i]._id;
          results.push(tie.input.icon.item(_id, {
            tag: "menuicon"
          }));
        }
        return results;
      })(), tie.input.icon.item("menu,home", {
        tag: "menuicon"
      }), (function() {
        var i, len, ref2, results;
        ref2 = icons.list;
        results = [];
        for (i = 0, len = ref2.length; i < len; i++) {
          _id = ref2[i]._id;
          results.push(tie.input.icon.item(_id, {
            tag: "bigicon"
          }));
        }
        return results;
      })(), tie.input.icon.item("menu,home", {
        tag: "bigicon"
      }));
    }
  };

  target("models/menu.coffee");

  describe("Query.menus", function() {
    it("data structure.", function() {
      assert.deepEqual(Query.menus.show("menu", "top", "normal").pluck("icon"), ["resize-full", "calc"]);
      assert.deepEqual(Query.menus.show("menu", "top", "full").pluck("icon"), ["resize-normal", "calc"]);
      assert.deepEqual(Query.menus.show("menu", "user", "normal").pluck("icon"), ["resize-full", "calc", "home"]);
      assert.deepEqual(Query.menus.show("menu", "book", "normal").pluck("icon"), ["calc", "pin", "home", "chat-alt"]);
      return assert.deepEqual(Query.menus.show("menu,home", "book", "normal").pluck("icon"), ["comment"]);
    });
    return it("shows menu buttons", function() {
      var c, tie;
      tie = (c = new component.controller()).tie;
      component.view(c);
      assert.deepEqual(tie.input.icon.option("menu,calc,cog"), Query.menus.find("menu,calc,cog"));
      assert.deepEqual(tie.input.icon.option("menu,home"), Query.menus.find("menu,home"));
      assert.deepEqual(tie.input.icon.item("menu").children[1].children, [0]);
      assert(tie.input.icon.item("menu").tag === "a");
      assert(tie.input.icon.item("menu", {
        tag: "menuicon"
      }).tag === "a");
      return assert(tie.input.icon.item("menu", {
        tag: "bigicon"
      }).tag === "section");
    });
  });

}).call(this);

(function() {
  var Timer, sinon;

  sinon = require("sinon");

  Timer = target("lib/timer.coffee").Timer;

  describe("Timer", function() {
    describe("module", function() {
      it("time_stamp", function() {
        assert(Timer.time_stamp(1400000000000 === "(水) 午前01時53分"));
        assert(Timer.time_stamp(Number.NaN === "(？) ？？..時..分"));
        return assert(Timer.time_stamp(1400000000000 === "(水) 午前01時53分"));
      });
      return it("date_time_stamp", function() {
        assert(Timer.date_time_stamp(1400000000000 === "2014-05-14 (水) 午前02時頃"));
        assert(Timer.date_time_stamp(Number.NaN === "....-..-.. (？) ？？..時頃"));
        return assert(Timer.date_time_stamp(1400000000000 === "2014-05-14 (水) 午前02時頃"));
      });
    });
    return describe("object", function() {
      it("show lax time", function() {
        var attr, clock, t;
        clock = sinon.useFakeTimers(0);
        attr = {
          onunload: function() {},
          update: function(text) {}
        };
        (t = new Timer(clock.now - 10800000)) && t.start(attr) && assert(t.text !== "3時間前");
        (t = new Timer(clock.now - 10800000 + 2)) && t.start(attr) && assert(t.text === "2時間前");
        (t = new Timer(clock.now - 3600000)) && t.start(attr) && assert(t.text === "1時間前");
        (t = new Timer(clock.now - 3600000 + 2)) && t.start(attr) && assert(t.text === "59分前");
        (t = new Timer(clock.now - 120000)) && t.start(attr) && assert(t.text === "2分前");
        (t = new Timer(clock.now - 60000)) && t.start(attr) && assert(t.text === "1分前");
        (t = new Timer(clock.now - 60000 + 2)) && t.start(attr) && assert(t.text === "1分以内");
        (t = new Timer(clock.now - 25000)) && t.start(attr) && assert(t.text === "1分以内");
        (t = new Timer(clock.now - 25000 + 2)) && t.start(attr) && assert(t.text === "25秒以内");
        (t = new Timer(clock.now + 25000 - 2)) && t.start(attr) && assert(t.text === "25秒以内");
        (t = new Timer(clock.now + 25000)) && t.start(attr) && assert(t.text === "1分以内");
        (t = new Timer(clock.now + 60000 - 2)) && t.start(attr) && assert(t.text === "1分以内");
        (t = new Timer(clock.now + 60000)) && t.start(attr) && assert(t.text === "1分後");
        (t = new Timer(clock.now + 120000)) && t.start(attr) && assert(t.text === "2分後");
        (t = new Timer(clock.now + 3600000 - 2)) && t.start(attr) && assert(t.text === "59分後");
        (t = new Timer(clock.now + 3600000)) && t.start(attr) && assert(t.text === "1時間後");
        (t = new Timer(clock.now + 10800000 - 2)) && t.start(attr) && assert(t.text === "2時間後");
        (t = new Timer(clock.now + 10800000)) && t.start(attr) && assert(t.text !== "3時間後");
        return clock.restore();
      });
      return it("show lax time by tick", function() {
        var attr, clock, timer;
        clock = sinon.useFakeTimers(0);
        attr = {
          onunload: function() {},
          update: function(text) {}
        };
        timer = new Timer(10800000);
        timer.start(attr);
        clock.tick(7200000) && timer.tick(clock.now) && assert(timer.text === "1時間後");
        clock.tick(60000) && timer.tick(clock.now) && assert(timer.text === "59分後");
        clock.tick(58 * 60000) && timer.tick(clock.now) && assert(timer.text === "1分後");
        clock.tick(1) && timer.tick(clock.now) && assert(timer.text === "1分以内");
        clock.tick(35000) && timer.tick(clock.now) && assert(timer.text === "25秒以内");
        clock.tick(49998) && timer.tick(clock.now) && assert(timer.text === "25秒以内");
        clock.tick(35000) && timer.tick(clock.now) && assert(timer.text === "1分以内");
        clock.tick(1) && timer.tick(clock.now) && assert(timer.text === "1分前");
        clock.tick(58 * 60000) && timer.tick(clock.now) && assert(timer.text === "59分前");
        clock.tick(60000) && timer.tick(clock.now) && assert(timer.text === "1時間前");
        return clock.restore();
      });
    });
  });

}).call(this);
