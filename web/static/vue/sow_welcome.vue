<script lang="coffee" src="./sow_welcome.coffee"></script>
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

  .btns
    span.width
      btn(v-model="style.width" as="480") 480
      btn(v-model="style.width" as="800") 800

    span.theme
      btn(v-model="style.theme" as="ririnra") 漆黒
      btn(v-model="style.theme" as="cinema") 煉瓦
      btn(v-model="style.theme" as="night")  闇夜
      btn(v-model="style.theme" as="star")   蒼穹
      btn(v-model="style.theme" as="wa")   和の国
      a(href="sow.cgi?ua=mb") 携帯
  .filmline
  .outframe_navimode(v-if="layoutfilter")
    .contentframe_navileft
      img.filmend(:src="filmend_url")
  .outframe(v-if=" ! layoutfilter")
    .contentframe
      img.filmend(:src="filmend_url")
</template>
