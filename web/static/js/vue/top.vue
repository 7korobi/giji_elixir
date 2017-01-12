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
</style>

<template lang="pug">
.top
  link(:href="style_url" rel="stylesheet" type="text/css")

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
    tbody(v-if=" mode === 'progress' ")
      tr.enum
        td
          a(:href="url('LOBBY')") lobby
          br
          | offparty
          br
        td
          | {{ vils('MORPHE') }}
          a(:href="url('MORPHE')") morphe
          br
          | {{ vils('CABALA') }}
          a(:href="url('CABALA')") cafe
          br
        td
          | wolf
          br
          | ultimate
          br
          | allstar
          br
        td
          | role-play
          br
          | RP-advance
          br
          | {{ vils('PERJURY') }}
          a(:href="url('PERJURY')") perjury
          br
          | {{ vils('XEBEC') }}
          a(:href="url('XEBEC')") xebec
          br
          | {{ vils('CRAZY') }}
          a(:href="url('CRAZY')") crazy
          br
          | {{ vils('CIEL') }}
          a(:href="url('CIEL')") ciel
          br

    tbody(v-if=" mode === 'finish' ")
      tr.enum
        td
          a(:href="url('LOBBY')") lobby
          br
          a(:href="url('OFFPARTY')") offparty
          br
        td
          a(:href="url('MORPHE')") morphe
          br
          a(:href="url('CABALA')") cafe
          br
        td
          a(:href="url('WOLF')") wolf
          br
          a(:href="url('ULTIMATE')") ultimate
          br
          a(:href="url('ALLSTAR')") allstar
          br
        td
          a(:href="url('RP')") role-play
          br
          a(:href="url('PRETENSE')") RP-advance
          br
          a(:href="url('PERJURY')") perjury
          br
          a(:href="url('XEBEC')") xebec
          br
          a(:href="url('CRAZY')") crazy
          br
          a(:href="url('CIEL')") ciel
          br

  h2
    | 人狼議事 xebec
    br
    |- Role Play braid -

</template>

