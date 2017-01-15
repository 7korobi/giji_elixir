<script lang="coffee">

{ Query } = require "memory-record"
module.exports =
  props: ["id", "write_at", "handle", "style", "log", "face", "job", "name", "sign"]
  data: -> {}
  computed:
    head: -> "#{@job} #{@name}"
    face_url: -> Query.faces.hash[@face].path

</script>

<style lang="scss" scoped>
</style>

<template lang="pug">
table(:key="id", :class="handle")
  tbody
    tr.say
      td.img
        img(:src="face_url" width="90" height="130")
      td.field
        .msg
          h3.mesname  {{ head }}
          p.mes_text(:class="style", v-html="log")
          p.mes_date
            span {{ sign }}
            timeago(:since="write_at")

</template>