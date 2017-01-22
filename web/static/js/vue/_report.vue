<script lang="coffee">
module.exports = require("./_chat.coffee").component_class()
</script>
<style lang="stylus" scoped>
</style>

<template lang="pug">
.chat.report(:key="id", :class="handle")
  p.name(v-if="head")
    | {{ head }}
    sup.pull-right(v-if="sign") {{ sign }}
  p.text(:class="style", v-html="log_html")
  p.date
    timeago(:since="write_at")

</template>
