<script lang="coffee" src="./sow_hello.coffee"></script>
<style lang="stylus" src="./_common.styl"></style>
<style lang="stylus" scoped>

.inframe
  padding: 25px 0 15px 0

</style>

<template lang="pug">
.outframe
  .contentframe
    .inframe
      chat(:id="key" v-for="key in hello_ids")
    h6 キャラクター
    chrs

    h6 ログイン

</template>
