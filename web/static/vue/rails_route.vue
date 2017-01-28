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
  { name: "top",   path: "/" }
  { name: "other", path: "*" }
]
routes.map (o)-> o.components =
  welcome: require "~vue/rails_welcome.vue"
  hello:   require "~vue/rails_hello.vue"

module.exports =
  el: "#top"
  router: new VueRouter
    mode: "history"
    routes: routes
</script>

