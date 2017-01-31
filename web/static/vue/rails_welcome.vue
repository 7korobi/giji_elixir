<script lang="coffee" src="./rails_welcome.coffee"></script>
<style lang="stylus" scoped>

#export
  border-collapse: separate
  border-spacing: 2px
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

.right-layout
  #export
    margin: 0 0 0 auto

.left-layout
  #export
    margin: 0 auto 0 0

h2
  height: 100px
  margin:   0
  padding: 25px 0 0 0
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
  margin: -11px 0 0 -2px
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
          a(v-if=" export_to === 'progress' " @click="slide('finish')") 進行中の村
          a(v-if=" export_to === 'finish' " @click="slide('progress')") 終了した村

  h2#title
    a(href="http://giji.check.jp") 人狼議事 総合トップ

  .btns
    span.font
      a(@click=" style.font = 'large'") 大判
      a(@click=" style.font = 'novel'") 明朝
      a(@click=" style.font = 'std'")   ゴシック
      a(@click=" style.font = 'small'") 繊細

    span.layout
      a(@click=" style.layout = 'left'")   左詰
      a(@click=" style.layout = 'center'") 中央
      a(@click=" style.layout = 'right'")  右詰

    span.width
      a(@click=" style.width = 'full'") 最大
      a(@click=" style.width = 'wide'") 広域
      a(@click=" style.width = 'std'")  狭域

    span.theme
      a(@click=" style.theme = 'cinema'") 煉瓦
      a(@click=" style.theme = 'star'")   蒼穹
      a(@click=" style.theme = 'night'")  闇夜
      a(@click=" style.theme = 'moon'")   月夜
      a(@click=" style.theme = 'wa'")   和の国
  .filmline
  .outframe
    .contentframe
      img.filmend(:src="filmend_url")
</template>
