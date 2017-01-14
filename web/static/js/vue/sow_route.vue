<style lang="scss" scoped>
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
routes.map (o)-> o.component = require "./top.vue"

module.exports =
  el: "#top"
  router: new VueRouter
    mode: "history"
    routes: routes
</script>

