<script lang="coffee">
module.exports = require("~vue/_chat.coffee").component_class()
</script>
<style lang="stylus" scoped>

.post
  padding:    0 12px 0     4px

.std-width
  .post
    margin:   0  0   6px  97px

.wide-width
  .post
    margin:   0  0   6px 107px


.ririnra-theme,
.wa-theme
  .post
    border-style: solid none solid solid;
    border-width: 2px  0   2px  18px
    border-color: #222;

.cinema-theme
  .post
    border-style: dashed none dashed solid;
    border-width: 2px  0   2px  18px
    border-color: #663;

.night-theme,
.moon-theme,
.star-theme
  .post
    border-style: none none solid solid;
    border-color: rgba(177,177,204,0.7);
    background:   rgba(  0,  0,  0,0.4);
    color:        #DDF;

</style>

<template lang="pug">
.chat.post(:class="handle")
  p.text
    strong(v-if="name") {{ name }}
    span(v-html="log_html")
  p.date
    timeago(:since="write_at")

</template>
