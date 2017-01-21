Vue = require "vue"

target "models/sow.coffee"
app = target "vue/sow_top.coffee"
app.beforeCreate = ->
  @$cookie =
    get: (key)-> cookie[key]
    set: (key, val, opt)-> cookie[key] = val
  cookie = {}
  @$route =
    name: "TEST"
    params: {}
    query:  {}
  @$router =
    replace: ->

vm = new Vue app

describe "vue_top_spec", ->
  it "has data", ->
    assert.deepEqual vm.style,
      theme: "cinema"
      width: 800

  it "computed", ->
    assert.deepEqual vm.style_url, "http://s3-ap-northeast-1.amazonaws.com/giji-assets/stylesheets/cinema800.css"
