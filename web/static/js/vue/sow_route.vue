<style lang="scss">
.night, .star {
  .talk a {
    background-color: rgba(255,255,255,0.3);
  }
  .talk b {
    background-color: rgba(255,255,255,0.3);
  }
}

.cinema, .wa {
  .talk a {
    background-color: rgba(0,0,0,0.3);
  }
  .talk b {
    background-color: rgba(255,255,255,0.3);
  }
}

</style>

<template lang="pug">
.route
  transition
    router-view

</template>

<script lang="coffee">
VueRouter = require 'vue-router'
{ Query } = require "memory-record"

require "../models/sow.coffee"

routes = [
  Query.folders.enable.pluck("route")...
  { name: "file",  path: "/*/:fname" }
  { name: "other", path: "*" }
]
routes.map (o)-> o.component = require "./sow_top.vue"

module.exports =
  el: "#top"
  router: new VueRouter
    mode: "history"
    routes: routes
</script>

