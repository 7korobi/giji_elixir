require "./_helper.coffee"
sinon = require "sinon"

{ Timer } = target "lib/timer.coffee"

describe "Timer", ->
  describe "module", ->
    it "time_stamp", ->
      assert Timer.time_stamp 1400000000000 == "(水) 午前01時53分"
      assert Timer.time_stamp  Number.NaN   == "(？) ？？..時..分"
      assert Timer.time_stamp 1400000000000 == "(水) 午前01時53分"

    it "date_time_stamp", ->
      assert Timer.date_time_stamp 1400000000000 == "2014-05-14 (水) 午前02時頃"
      assert Timer.date_time_stamp  Number.NaN   == "....-..-.. (？) ？？..時頃"
      assert Timer.date_time_stamp 1400000000000 == "2014-05-14 (水) 午前02時頃"

  describe "object", ->
    it "show lax time", ->
      clock = sinon.useFakeTimers(0)
      attr =
        onunload: ->
        update: (text)->
      (t = new Timer(clock.now - 10800000    )) && t.start(attr) && assert t.text != "3時間前"
      (t = new Timer(clock.now - 10800000 + 2)) && t.start(attr) && assert t.text == "2時間前"
      (t = new Timer(clock.now -  3600000    )) && t.start(attr) && assert t.text == "1時間前"
      (t = new Timer(clock.now -  3600000 + 2)) && t.start(attr) && assert t.text == "59分前"
      (t = new Timer(clock.now -   120000    )) && t.start(attr) && assert t.text == "2分前"
      (t = new Timer(clock.now -    60000    )) && t.start(attr) && assert t.text == "1分前"
      (t = new Timer(clock.now -    60000 + 2)) && t.start(attr) && assert t.text == "1分以内"
      (t = new Timer(clock.now -    25000    )) && t.start(attr) && assert t.text == "1分以内"
      (t = new Timer(clock.now -    25000 + 2)) && t.start(attr) && assert t.text == "25秒以内"
      (t = new Timer(clock.now +    25000 - 2)) && t.start(attr) && assert t.text == "25秒以内"
      (t = new Timer(clock.now +    25000    )) && t.start(attr) && assert t.text == "1分以内"
      (t = new Timer(clock.now +    60000 - 2)) && t.start(attr) && assert t.text == "1分以内"
      (t = new Timer(clock.now +    60000    )) && t.start(attr) && assert t.text == "1分後"
      (t = new Timer(clock.now +   120000    )) && t.start(attr) && assert t.text == "2分後"
      (t = new Timer(clock.now +  3600000 - 2)) && t.start(attr) && assert t.text == "59分後"
      (t = new Timer(clock.now +  3600000    )) && t.start(attr) && assert t.text == "1時間後"
      (t = new Timer(clock.now + 10800000 - 2)) && t.start(attr) && assert t.text == "2時間後"
      (t = new Timer(clock.now + 10800000    )) && t.start(attr) && assert t.text != "3時間後"
      clock.restore()

    it "show lax time by tick", ->
      clock = sinon.useFakeTimers(0)
      attr =
        onunload: ->
        update: (text)->
      timer = new Timer(10800000)
      timer.start attr
      clock.tick(   7200000) && timer.tick(clock.now) && assert timer.text == "1時間後"
      clock.tick(     60000) && timer.tick(clock.now) && assert timer.text == "59分後"
      clock.tick(58 * 60000) && timer.tick(clock.now) && assert timer.text == "1分後"
      clock.tick(         1) && timer.tick(clock.now) && assert timer.text == "1分以内"
      clock.tick(     35000) && timer.tick(clock.now) && assert timer.text == "25秒以内"
      clock.tick(     49998) && timer.tick(clock.now) && assert timer.text == "25秒以内"
      clock.tick(     35000) && timer.tick(clock.now) && assert timer.text == "1分以内"
      clock.tick(         1) && timer.tick(clock.now) && assert timer.text == "1分前"
      clock.tick(58 * 60000) && timer.tick(clock.now) && assert timer.text == "59分前"
      clock.tick(     60000) && timer.tick(clock.now) && assert timer.text == "1時間前"

      clock.restore()
