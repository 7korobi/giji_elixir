Vue = require "vue"

vm = new Vue target "vue/top.coffee"

describe "top.vue", ->
  it "has data", ->
    assert.deepEqual vm.style,
      theme: "cinema"
      width: 800

    assert.deepEqual vm.banner,
      file: "title580r.jpg"
      width:  580
      height: 161

  it "computed", ->
    assert.deepEqual vm.style_url, "http://giji-assets.s3-website-ap-northeast-1.amazonaws.com/stylesheets/cinema800.css"