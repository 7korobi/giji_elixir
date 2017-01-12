require "../models/sow.coffee"
{ Query } = require "memory-record"

# width="580" height="161"
# width="458" height="112"

file = (path)->
  "http://giji-assets.s3-website-ap-northeast-1.amazonaws.com" + path

module.exports =
  data: ->
    style:
      theme: "cinema"
      width: 800
    banner:
      file: "title580r.jpg"
      width:  580
      height: 161

    mode: "progress"

  computed:
    style_url:  -> file "/stylesheets/#{ @style.theme }#{ @style.width }.css"
    banner_url: -> file "/images/banner/#{ @banner.file }"

  methods:
    vils: (id)->
      max_vils = Query.folders.hash[id].config.cfg.MAX_VILLAGES
      "#{max_vils}村:"

    url: (id)->
      switch @mode
        when "progress"
          Query.folders.hash[id].config.cfg.URL_SW + "/sow.cgi"
        when "finish"
          file "/stories/all?folder=#{id}"
    slide: (to)->
      console.log @$route
      console.log @$route.params
      @mode = to

