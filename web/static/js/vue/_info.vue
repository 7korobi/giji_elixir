<script lang="coffee">
module.exports = require("./_chat.coffee").component_class()
</script>
<style lang="stylus" scoped>
</style>

<template lang="pug">
.info(:key="id", :class="handle")
  h3.mesname(v-if="head")  {{ head }}
  p.mes_text(:class="style", v-html="log_html")
  p.mes_date
    span.emboss {{ sign }}
    timeago(:since="write_at")

</template>
