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

  global.sessionStorage = {
    getItem: function() {},
    setItem: function() {}
  };

  global.localStorage = {
    getItem: function() {},
    setItem: function() {}
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
  var Collection, InputTie, Model, Query, Rule, Url, WebStore, _, component, deploy, m, ref, ref1;

  _ = require("lodash");

  m = require("mithril");

  ref = require("memory-record"), Collection = ref.Collection, Model = ref.Model, Query = ref.Query, Rule = ref.Rule;

  ref1 = require("mithril-tie"), InputTie = ref1.InputTie, WebStore = ref1.WebStore, Url = ref1.Url, deploy = ref1.deploy;

  deploy({
    window: {
      scrollX: 0,
      scrollY: 0,
      devicePixelRatio: 2
    }
  });

  Url.define = function(key) {
    return Query.stores.hash[key];
  };

  Url.maps({
    search: {
      css: "css=:theme~:mode"
    }
  });

  WebStore.maps({
    session: ["menu", "site"]
  });

  component = {
    controller: function() {
      var tie;
      Model.menu.set_tie(tie = InputTie.form(WebStore.params, []));
    },
    view: function() {
      var tie;
      tie = Model.menu.tie;
      tie.draw();
      return m(".menus", Query.menus.icons(tie.params, {
        tag: "menuicon"
      }), Query.menus.icons(tie.params, {
        tag: "bigicon"
      }));
    }
  };

  target("models/menu.coffee");

  describe("Query.menus", function() {
    var c;
    c = new component.controller();
    it("data structure.", function() {
      var params, ref2, ref3, ref4, ref5, ref6;
      params = ["menu", "top", "normal"];
      assert.deepEqual((ref2 = Query.menus).show.apply(ref2, params).pluck("icon"), ["resize-full", "calc"]);
      params = ["menu", "top", "full"];
      assert.deepEqual((ref3 = Query.menus).show.apply(ref3, params).pluck("icon"), ["resize-normal", "calc"]);
      params = ["menu", "user", "normal"];
      assert.deepEqual((ref4 = Query.menus).show.apply(ref4, params).pluck("icon"), ["resize-full", "calc", "home"]);
      params = ["menu", "book", "normal"];
      assert.deepEqual((ref5 = Query.menus).show.apply(ref5, params).pluck("icon"), ["calc", "pin", "home", "chat-alt"]);
      params = ["menu,home", "book", "normal"];
      return assert.deepEqual((ref6 = Query.menus).show.apply(ref6, params).pluck("icon"), ["comment"]);
    });
    it("shows menu buttons", function() {
      var tie;
      component.view(c);
      tie = Model.menu.tie;
      assert.deepEqual(tie.input.menu.option("menu,calc,cog"), Query.menus.find("menu,calc,cog"));
      assert.deepEqual(tie.input.menu.option("menu,home"), Query.menus.find("menu,home"));
      assert.deepEqual(tie.input.menu.item("menu").children[1].children, [0]);
      assert(tie.input.menu.item("menu").tag === "a");
      assert(tie.input.menu.item("menu", {
        tag: "menuicon"
      }).tag === "a");
      return assert(tie.input.menu.item("menu", {
        tag: "bigicon"
      }).tag === "section");
    });
    return it("sequence", function() {
      var tie;
      tie = Model.menu.tie;
      component.view(c);
      assert.deepEqual(tie.params, {
        pop: false,
        menu: "menu",
        width: "full",
        site: "top",
        theme: "cinema",
        font: "std"
      });
      tie.do_change(tie.input.menu, "menu,resize-normal");
      component.view(c);
      assert.deepEqual(tie.params, {
        pop: true,
        menu: "menu",
        width: "std",
        site: "top",
        theme: "cinema",
        font: "std"
      });
      tie.do_change(tie.input.menu, "menu,home");
      component.view(c);
      assert.deepEqual(tie.params, {
        pop: true,
        menu: "menu,home",
        width: "std",
        site: "top",
        theme: "cinema",
        font: "std"
      });
      tie.do_change(tie.input.menu, "menu,home");
      component.view(c);
      return assert.deepEqual(tie.params, {
        pop: false,
        menu: "menu,home",
        width: "std",
        site: "top",
        theme: "cinema",
        font: "std"
      });
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
