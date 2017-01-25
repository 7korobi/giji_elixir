Vue = require 'vue'
Vue.use require 'vue-meta'
Vue.use require 'vue-router'
Vue.use require 'vue-cookie'

Vue.use require('vue-async-computed'),
  errorHandler: (msg)->
    console.log msg

Vue.component "vSelect", require 'vue-select'
Vue.component "timeago", require '~vue/_timeago'

Vue.component "report", require '~vue/_report.vue'
Vue.component "post",   require '~vue/_post.vue'
Vue.component "talk",   require '~vue/_talk.vue'
# Vue.component "calc",  require '~vue/_calc.vue'
Vue.component "chat",   require '~vue/_chat'

Vue.component "chrs",   require '~vue/_chrs.vue'
