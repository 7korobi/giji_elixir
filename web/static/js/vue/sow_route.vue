<style lang="scss">
</style>

<template lang="pug">
transition
  div
    router-view(name="welcome")
    router-view(name="hello")
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
routes.map (o)-> o.components =
  welcome: require "./sow_welcome.vue"
  hello:   require "./sow_hello.vue"

module.exports =
  el: "#top"
  router: new VueRouter
    mode: "history"
    routes: routes
</script>

