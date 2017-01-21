Vue = require 'vue'
Vue.use require 'vue-meta'
Vue.use require 'vue-router'
Vue.use require 'vue-cookie'

Vue.use require('vue-async-computed'),
  errorHandler: (msg)->
    console.log msg

Vue.component "vSelect", require 'vue-select'
Vue.component "timeago", require './_timeago'

Vue.component "talk",    require './_talk.vue'
Vue.component "info",    require './_info.vue'
Vue.component "action",  require './_action.vue'
# Vue.component "calc",    require './_calc.vue'
Vue.component "chat", require './_chat'

Vue.component "chrs",    require './_chrs.vue'
