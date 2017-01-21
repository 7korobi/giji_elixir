<script lang="coffee">
module.exports = require("./_chat.coffee").component_class()
</script>
<style lang="stylus" scoped>
</style>

<template lang="pug">
table.talk(:key="id", :class="handle")
  tbody
    tr.say
      td.img
        img(:src="face_url" width="90" height="130")
      td.field
        .msg
          h3.mesname(v-if="head")  {{ head }}
          p.mes_text(:class="style", v-html="log_html")
          p.mes_date
            span.emboss {{ sign }}
            timeago(:since="write_at")

</template>