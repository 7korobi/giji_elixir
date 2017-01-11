import Vue from "vue"
import VueRouter from "vue-router"
Vue.use(VueRouter);

import route from "./vue/sow_route.vue"

window.d_route = route;
console.log(route);
new Vue(route).$mount("#top");
