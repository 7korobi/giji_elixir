<script lang="coffee">

module.exports =
  props: ["id", "write_at", "handle", "style", "log", "job", "name", "sign"]
  data: -> {}
  computed:
    head: ->
      if @name
        "#{@job} #{@name}"
      else
        null

</script>

<style lang="scss" scoped>
</style>

<template lang="pug">
.info(:key="id", :class="handle")
  h3.mesname(v-if="head")  {{ head }}
  p.mes_text(:class="style", v-html="log")
  p.mes_date
    span {{ sign }}
    timeago(:since="write_at")

</template>
