<script lang="coffee" src="./sow_welcome.coffee"></script>
<style lang="stylus" scoped>

h2
  height: 100px
  padding-top: 25px
  white-space: pre
  font-size: xx-large
  line-height: 1.2em
  background-color: rgba(92, 92, 32, 0.5)

.wa-theme
  .filmline
    background-image: url(http://s3-ap-northeast-1.amazonaws.com/giji-assets/images/bg/film-wa-border.png)

.filmline
  margin: 0
  height: 11px
  background-repeat: repeat-x
  background-image: url(http://s3-ap-northeast-1.amazonaws.com/giji-assets/images/bg/film-border.png)
  .contentframe
    background-image: none

#welcome
  background-size:  cover
  background-image: url(http://s3-ap-northeast-1.amazonaws.com/giji-assets/images/bg/fhd-giji.png)
  .btns
    background-color: rgba(77, 78, 70, 0.9)

#export
  padding: 30px
  margin:   0px auto

  thead
    text-align: center
  th,
  td,
  td a
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
  .filmend
    margin: 0 0 0 -9px

</style>

<template lang="pug">
#welcome(:style="welcome_style")
  table#export
    thead
      tr
        th ロビー
        th 夢の形
        th 陰謀
        th ＲＰ
    tbody
      tr
        td
          sow(folder="LOBBY")
          sow(folder="OFFPARTY")
        td
          sow(folder="MORPHE")
          sow(folder="CABALA") cafe
        td
          sow(folder="WOLF")
          sow(folder="ULTIMATE")
          sow(folder="ALLSTAR")
        td
          sow(folder="RP") role-play
          sow(folder="PRETENSE") RP-advance
          sow(folder="PERJURY")
          sow(folder="XEBEC")
          sow(folder="CRAZY")
          sow(folder="CIEL")

  h2#title(v-html="current.title")
  .btns
    span.mode
      b(v-if=" mode === 'progress' " @click="slide('finish')") 進行中の村
      b(v-if=" mode === 'finish' " @click="slide('progress')") 終了した村
    span.style
      a(@click=" style.width = 480") 480
      a(@click=" style.width = 800") 800
    span.theme
      a(@click=" style.theme = 'ririnra'") 漆黒
      a(@click=" style.theme = 'cinema'") 煉瓦
      a(@click=" style.theme = 'night'") 月夜
      a(@click=" style.theme = 'star'") 蒼穹
      a(@click=" style.theme = 'wa'") 和の国
      a(href="sow.cgi?ua=mb") 携帯
  .filmline
    .contentframe
      img.filmend(:src="filmend_url")
</template>
