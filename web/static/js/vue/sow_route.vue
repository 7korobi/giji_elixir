<style lang="scss" scoped>
</style>

<template lang="pug">
.route
  transition
    router-view

</template>

<script lang="coffee">
Vue = require "vue"
VueRouter = require "vue-router"
Vue.use VueRouter

{ Query } = require "memory-record"

top = Object.assign require("./top.vue"), require("./top")

routes = [
  Query.folders.enable.pluck("route")...
  { name: "file",  path: "/*/:fname" }
  { name: "other", path: "*" }
]
routes.map (o)-> o.component = top
console.log routes

module.exports.default =
  el: "#top"
  router: new VueRouter
    mode: "history"
    routes: routes
</script>

