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
      width:  770 # 458  580  770
      height: 161 # 112  161  161

    mode: "progress"

  computed:
    style_url:  -> file "/stylesheets/#{ @style.theme }#{ @style.width }.css"
    banner_url: -> file "/images/banner/title#{ @banner.width }lupino.png"

  methods:
    vils: (id)->
      max_vils = Query.folders.hash[id].max_vils
      if max_vils && "progress" == @mode
        "#{max_vils}村:"
      else
        ""

    url: (id)->
      switch @mode
        when "progress"
          Query.folders.hash[id].route?.path
        when "finish"
          file "/stories/all?folder=#{id}"
    slide: (to)->
      console.log @$route
      console.log @$route.params
      @mode = to

  components:
    sow:
      functional: true
      props: ["folder", "mode"]
      render: (m, ctx)->
        { mode, folder } = ctx.props
        children = ctx.children ? [ folder.toLowerCase() ]

        vils = ctx.parent.vils folder
        href = ctx.parent.url  folder

        m "p", [
          vils
          m "a",{ attrs: { href }}, children
        ]

