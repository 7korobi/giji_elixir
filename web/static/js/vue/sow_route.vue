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

top = Object.assign require("./top.vue"), require("./top")
window.d_top = top
console.log top


module.exports.default =
  el: "#top"
  router: new VueRouter
    mode: "history"
    routes: [
      { path: "/*/:fname", component: top }
      { path: "*", component: top }
    ]
</script>


