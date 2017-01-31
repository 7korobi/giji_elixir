<template lang="pug">
transition
  div
    router-view(name="welcome")
    router-view(name="hello")
</template>

<script lang="coffee">
VueRouter = require 'vue-router'
{ Query } = require "memory-record"

require "~js/models/sow.coffee"

routes = [
  Query.folders.enable.pluck("route")...
  { name: "file",  path: "/*/:fname" }
  { name: "other", path: "*" }
]
routes.map (o)-> o.components =
  welcome: require "~vue/sow_fix_welcome.vue"
  hello:   require "~vue/sow_hello.vue"

module.exports =
  el: "#top"
  router: new VueRouter
    mode: "history"
    routes: routes
</script>

