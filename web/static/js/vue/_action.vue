<script lang="coffee">

module.exports =
  props: ["id", "write_at", "handle", "log", "name", "sign"]
  data: -> {}

</script>

<style lang="scss" scoped>
</style>

<template lang="pug">
.action(:class="handle")
  p
    span {{ name }}
    span(v-html="log")
  p.mes_date
    span {{ sign }}
    timeago(:since="write_at")

</template>
