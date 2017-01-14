Vue = require "vue"

app = target "vue/top.coffee"
app.beforeCreate = ->
  @$route =
    name: "TEST"
    params: {}
    query:  {}
vm = new Vue app

describe "top.vue", ->
  it "has data", ->
    assert.deepEqual vm.style,
      theme: "cinema"
      width: 800

    assert.deepEqual vm.banner,
      width:  770
      height: 161

  it "computed", ->
    assert.deepEqual vm.style_url, "http://giji-assets.s3-website-ap-northeast-1.amazonaws.com/stylesheets/cinema800.css"
