Vue = require 'vue'
Vue.use require 'vue-meta'
Vue.use require 'vue-router'
Vue.use require 'vue-cookie'

Vue.use require('vue-async-computed'),
  errorHandler: (msg)->
    console.log msg

Vue.component "vSelect", require 'vue-select'
Vue.component "timeago", require './_timeago'
Vue.component "info",    require './_info.vue'
Vue.component "action",  require './_action.vue'
Vue.component "talk",    require './_talk.vue'
# Vue.component "calc",    require './_calc.vue'
Vue.component "chat", require './_chat'


{ Collection, Model, Query, Rule } = require "memory-record"
require '../models/potof'
Collection.potof.set
  "LOBBY-Welcome-0":
    open_at:  1484445101000
    write_at: 1484445101000
    close_at: 1484445101000
    face_id: "t31"
    job:  "呵呵老会"
    name: "ホウイチ"
    sign: "ななころび"

require '../models/phase'
Collection.phase.set
  "LOBBY-Welcome-0":
    write_at: 1484445101000
    name: "通常発言"
    handle: "mes_nom"

require '../models/chat'
Collection.chat.set
  "LOBBY-Welcome-0-3":
    write_at: 1484445101004
    show: "info"
    style: "plain"
    log: """
じゃじゃーん
"""
  "LOBBY-Welcome-0-2":
    write_at: 1484445101003
    potof_id: "LOBBY-Welcome-0"
    show: "action"
    style: "plain"
    log: """
が、うぇるかむ
"""

  "LOBBY-Welcome-0-1":
    open_at:  1484445101002
    write_at: 1484445101002
    close_at: 1484445101002
    potof_id: "LOBBY-Welcome-0"
    section_id: "LOBBY-Welcome-1"
    show: "talk"
    style: "plain"
    log: """
こちらのページは<span style="color:#FFF">（陣営勝利を求めない）完全RP村、勝利追求を含むRP村</span>用に調整してあるよ。
早い者勝ちが原則だけれど、<a href="http://jsfun525.gamedb.info/wiki/?%B4%EB%B2%E8%C2%BC%CD%BD%C4%EA%C9%BD" ng-href="{{link.plan}}">企画村予定表</a>という便利なページも見てみよう。<br>

以下がおおざっぱな、他州との相違点なんだ。
<ul style="font-size: smaller;">
<li><a href="sow.cgi?cmd=rule#mind">参加者の心構え</a>。ガチとは違うのだよ。ガチとは。
</li><li><a href="http://crazy-crazy.sakura.ne.jp/giji/?(List)SayCnt">発言ptの量</a>。
</li><li>村の説明は4000字まで記述できます。
</li><li>他、細かい調整が入っています。<a href="http://crazy-crazy.sakura.ne.jp/giji/">仕様変更</a>を参考にしましょう。
</li></ul>
"""
  "LOBBY-Welcome-0-0":
    write_at: 1484445101001
    show: "info"
    style: "title"
    log: """
人狼議事<br>
ロビー
"""
