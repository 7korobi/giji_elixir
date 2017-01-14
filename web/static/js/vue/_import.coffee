Vue = require 'vue'
Vue.use require 'vue-intl'
Vue.use require 'vue-meta'
Vue.use require 'vue-router'
Vue.use require 'vue-cookie'

Vue.use require('vue-async-computed'),
  errorHandler: (msg)->
    console.log msg

Vue.use require('vue-timeago'),
  name: 'timeago'
  locale: 'ja-JP'
  locales:
    'ja-JP': [
      "たった今"
      "%s 秒前"
      "%s 分前"
      "%s 時間前"
      "%s 日前"
      "%s 週間前"
      "%s ヶ月前"
      "%s 年前"
    ]

vSelect = require 'vue-select'
Vue.component { vSelect }
