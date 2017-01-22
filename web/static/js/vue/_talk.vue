<script lang="coffee">
module.exports = require("./_chat.coffee").component_class()
</script>
<style lang="stylus" scoped>

.wide-width .talk
  th img
    margin:  0 4px 6px 12px
  .chat
    margin:  0 7px 6px  6px

.std-width .talk
  th img
    margin:  0 4px 6px  3px
  .chat
    margin:  0 2px 6px  6px

.talk
  width: 100%
  text-align:    left
  th
    border: 0;
    background: transparent
    vertical-align: top
    padding: 0 4px
  td
    border: 0;
    background: transparent
    vertical-align: middle

  .chat
    padding: 0 4px

.line_text
  white-space: nowrap
  overflow: hidden
  text-overflow: ellipsis


.text
  overflow:   visible
  word-wrap:  break-word
  word-break: break-strict

.text,
.head .mono
  padding: 0

.head:first-line
  font-weight: 700

</style>

<template lang="pug">
table.talk(:key="id")
  tbody(:class="handle")
    tr
      th
        img(:src="face_url" width="90" height="130")
      td
        .chat
          p.name(v-if="head")
            | {{ head }}
            sup.pull-right(v-if="sign") {{ sign }}
          p.text(:class="style", v-html="log_html")
          p.date
            timeago(:since="write_at")

</template>