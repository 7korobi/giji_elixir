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
  var Collection, InputTie, Model, Query, Rule, deploy, ref, ref1;

  ref = require("memory-record"), Collection = ref.Collection, Model = ref.Model, Query = ref.Query, Rule = ref.Rule;

  ref1 = require("mithril-tie"), InputTie = ref1.InputTie, deploy = ref1.deploy;

  deploy({
    window: {
      scrollX: 0,
      scrollY: 0,
      devicePixelRatio: 2
    }
  });

  target("models/menu.coffee");

  describe("Query.menus", function() {
    it("data structure.", function() {
      assert.deepEqual(Query.menus.show("menu", "top", "normal").pluck("icon"), ["resize-full"]);
      assert.deepEqual(Query.menus.show("menu", "top", "full").pluck("icon"), ["resize-normal"]);
      assert.deepEqual(Query.menus.show("menu", "user", "normal").pluck("icon"), ["resize-full", "home"]);
      assert.deepEqual(Query.menus.show("menu", "book", "normal").pluck("icon"), ["pin", "home", "chat-alt"]);
      return assert.deepEqual(Query.menus.show("menu,home", "book", "normal").pluck("icon"), ["comment"]);
    });
    return it("shows menu buttons", function() {
      var c, component, state, tie;
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
              options: {
                cog: "画面表示を調整します。",
                home: "村の設定、アナウンスを表示します。"
              },
              option_default: {
                label: "icon default"
              }
            })
          ];
        },
        view: function(arg) {
          var tie;
          tie = arg.tie;
          return tie.draw();
        }
      };
      tie = (c = new component.controller()).tie;
      component.view(c);
      assert_only(tie.input.icon.option("cog"), {
        _id: "cog",
        label: "画面表示を調整します。"
      });
      assert_only(tie.input.icon.option("home"), {
        _id: "home",
        label: "村の設定、アナウンスを表示します。"
      });
      assert_only(tie.input.icon.option(null), {
        label: "icon default",
        "data-tooltip": "選択しない"
      });
      tie.input.icon.options.cog.badge = function() {
        return 123;
      };
      assert(tie.input.icon.item("cog").children[1].children[0] === 123);
      assert(tie.input.icon.item("cog").tag === "a");
      assert(tie.input.icon.item("cog", {
        tag: "menuicon"
      }).tag === "a");
      return assert(tie.input.icon.item("cog", {
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
