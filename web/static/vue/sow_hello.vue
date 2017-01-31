<script lang="coffee" src="~vue/sow_hello.coffee"></script>
<style lang="stylus" scoped>

.inframe
  padding: 25px 0 15px 0

</style>

<template lang="pug">
div
  .outframe_navimode(v-if="layoutfilter")
    .contentframe_navileft
      .inframe
        chat(:id="key" v-for="key in hello_ids")
        h6 ログイン
  .outframe(v-if=" ! layoutfilter")
    .contentframe
      .inframe
        chat(:id="key" v-for="key in hello_ids")
        h6 ログイン

</template>
