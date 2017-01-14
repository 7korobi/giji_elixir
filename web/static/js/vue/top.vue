<script lang="coffee" src="./top.coffee">

<style lang="scss" scoped>
.expand-transition {
  transition: all .3s ease;
}
.expand-enter, .expand-leave {
  height: 0;
  padding: 0 10px;
  opacity: 0;
}

h2 {
  font-size: xx-large;
}

.board th,
.board td,
.board td a {
  font-size: 15px;
}
.enum td {
  vertical-align: top;
}
.tap {
  height: 4em;
  vertical-align: bottom;
}

.choice {
  text-align: right;
}

</style>

<template lang="pug">
.top
  h1
    a(href="./sow.cgi?")
      img(:src="banner_url", :width="banner.width", :height="banner.height" alt="人狼議事")

  table.board
    thead
      tr.tap(v-if=" mode === 'progress' ")
        th.choice(colspan=2 key="p")
          strong 進行中の村
        th.choice(colspan=2 key="f")
          label.btn.edge(@click="slide('finish')") 終了した村を見る
      tr.tap(v-if=" mode === 'finish' ")
        th.choice(colspan=2 key="p")
          label.btn.edge(@click="slide('progress')") 進行中の村を見る
        th.choice(colspan=2 key="f")
          strong 終了した村
      tr
        th.choice ロビー
        th.choice 夢の形
        th.choice 陰謀
        th.choice ＲＰ
    tbody
      tr.enum
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

  .choice
    a(@click=" style.width = 480") 480
    a(@click=" style.width = 800") 800
    | ￤
    a(@click=" style.theme = 'ririnra'") 漆黒
    a(@click=" style.theme = 'cinema'") 煉瓦
    a(@click=" style.theme = 'night'") 月夜
    a(@click=" style.theme = 'star'") 蒼穹
    a(@click=" style.theme = 'wa'") 和の国
    a(href="sow.cgi?ua=mb") 携帯

  h2(v-html="current.title")
    | 人狼議事 xebec
    br
    |- Role Play braid -

</template>

