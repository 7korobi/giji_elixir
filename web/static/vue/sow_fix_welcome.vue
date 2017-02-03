<script lang="coffee" src="./sow_fix_welcome.coffee"></script>
<style lang="stylus" scoped>

#export
  padding: 30px
  margin:   0px auto

  thead, tfoot
    text-align: center
  th, td, a
    font-size: 15px
  th
    background-color: #444
  td
    background-color: black
    vertical-align: top
    padding: 0 3px

.std-width
  #export
    margin: 0 0 0 auto
  .btns
    text-align: right
  .filmend
    margin: -11px 0 0 -8px


h2
  height: 100px
  padding-top: 25px
  white-space: pre
  font-size: xx-large
  line-height: 1.1em
  background-color: rgba(92, 92, 32, 0.5)
  sup
    font-size: large
  a
    color: #fff
    &:hover, &:focus
      box-shadow:
        0 0 20px 3px lighten(#fff, 50%) inset
    &:active
      box-shadow:
        0 0 20px 3px lighten(rgba(2,92,32,0.5), 50%) inset


.moon-theme,
.wa-theme
  .filmline
    background-image: url(../images/bg/film-wa-border.png)

.filmline
  margin: 0
  height: 11px
  background-repeat: repeat-x
  background-image: url(../images/bg/film-border.png)
  .contentframe
    background-image: none

.filmend
  margin: -11px 0 0 0px
.outframe
  height: 0
  .contentframe
    text-align: left

#welcome
  background-size:  cover
  background-image: url(../images/bg/fhd-giji.png)
  .btns
    background-color: rgba(77, 78, 70, 0.9)
</style>

<template lang="pug">
#welcome(:style="welcome_style")
  table#export(v-if="mode")
    thead
      tr
        th.btns ロビー
        th.btns 夢の形
        th.btns 陰謀
        th.btns ＲＰ
    tbody
      tr
        td.links
          sow(folder="LOBBY")
          sow(folder="OFFPARTY")
        td.links
          sow(folder="MORPHE")
          sow(folder="CABALA") cafe
        td.links
          sow(folder="WOLF")
          sow(folder="ULTIMATE")
          sow(folder="ALLSTAR")
        td.links
          sow(folder="RP") role-play
          sow(folder="PRETENSE") RP-advance
          sow(folder="PERJURY")
          sow(folder="XEBEC")
          sow(folder="CRAZY")
          sow(folder="CIEL")

    tfoot
      tr
        th.btns(colspan=4)
          btn(v-model="export_to" as="finish")   終了した村
          btn(v-model="export_to" as="progress") 進行中の村
      tr
        th.btns(colspan=4)
          a(href="http://giji.check.jp") 総合トップ

  h2#title
    a(:href="current_url" v-if="'CABALA' == current._id")
      | 人狼議事 Cabala Cafe
    a(:href="current_url" v-if="'LOBBY' == current._id")
      | 人狼議事 ロビー
    a(:href="current_url" v-if="'TEST' == current._id")
      | 人狼議事 手元テスト
    a(:href="current_url" v-if="'CIEL' == current._id")
      | 人狼議事 ciel
      br
      sup - Role Play Cheat -
    a(:href="current_url" v-if="'PERJURY' == current._id")
      | 人狼議事 perjury rulez
      br
      sup - Role Play braid -
    a(:href="current_url" v-if="'XEBEC' == current._id")
      | 人狼議事 xebec
      br
      sup - Role Play braid -
    a(:href="current_url" v-if="'CRAZY' == current._id")
      | 人狼議事 crazy
      br
      sup - Role Play braid -

  .btns(v-if="cog")
    span.device
      select(v-model="style.device")
        option(value="simple") 携帯用
        option(value="mobile") タブレット
        option(value="pc")     ＰＣ用
    span.order
      select(v-model="style.order")
        option(value="asc")  上から下へ
        option(value="desc") 下から上へ
    span.row
      select(v-model="style.row")
        option(value="10")       10行
        option(value="20")       20行
        option(value="30")       30行
        option(value="50")       50行
        option(value="100")     100行
        option(value="300")     300行
        option(value="1000")   1000行
        option(value="3000")   3000行
        option(value="10000") 10000行
        option(value="30000") 30000行
  .btns
    span.font
      btn(v-model="style.font" as="large-font") 大判
      btn(v-model="style.font" as="novel-font") 明朝
      btn(v-model="style.font" as="std-font") ゴシック
      btn(v-model="style.font" as="small-font") 繊細

    span.msg(v-if="cog")
      btn(v-model="style.msg" as="mini-msg")   携帯
      btn(v-model="style.msg" as="right-msg") 右半分
      btn(v-model="style.msg" as="center-msg") 中央
      btn(v-model="style.msg" as="game-msg")  大判左
      btn(v-model="style.msg" as="large-msg")  大判

    span.msg(v-if=" ! cog")
      btn(v-model="style.msg" as="mini-msg")   480
      btn(v-model="style.msg" as="center-msg") 800
    span.theme
      btn(v-model="style.theme" as="cinema") 煉瓦
      btn(v-model="style.theme" as="moon")   月夜
      btn(v-model="style.theme" as="star")   蒼穹
      btn(v-model="style.theme" as="wa")   和の国
      a(href="sow.cgi?ua=mb") 携帯
      a.fa.fa-cogs(@click="cog = ! cog")
  .filmline
  .outframe
    .contentframe
      img.filmend(:src="filmend_url")
</template>
