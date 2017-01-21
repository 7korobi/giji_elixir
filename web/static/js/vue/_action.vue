<script lang="coffee">
module.exports = require("./_chat.coffee").component_class()
</script>
<style lang="stylus" scoped>
</style>

<template lang="pug">
.action(:class="handle")
  p.mes_text
    span {{ name }}
    span(v-html="log_html")
  p.mes_date
    span.emboss {{ sign }}
    timeago(:since="write_at")

</template>
