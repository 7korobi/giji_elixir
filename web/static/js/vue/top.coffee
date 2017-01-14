require "../models/sow.coffee"
{ Query } = require "memory-record"

file = (path)->
  "http://giji-assets.s3-website-ap-northeast-1.amazonaws.com" + path

module.exports =
  metaInfo: ->
    title: @current.title
    titleTemplate: '%s トップページ'
    link: [
      { rel: 'stylesheet', type: 'text/css', href: @style_url }
    ]
    changed: (newInfo, addedTags, removedTags)->
      console.log arguments

  data: ->
    current: Query.folders.hash.LOBBY
    mode: "progress"
    style:
      theme: "cinema"
      width: 800

  created: ->
    { css } = @$route.query
    if css
      [..., theme, width] = css.match(/^(\D+)(\d+)$/)
    theme ?= "cinema"
    width ?= 800
    @style = { theme, width }
    @current = Query.folders.hash[@$route.name] ? @current

  computed:
    banner_url: -> file "/images/banner/title#{ @banner.width }lupino.png"
    style_url: ->
      switch @style.theme
        when "ririnra"
          width = ""
        else
          width = @style.width
      file "/stylesheets/#{ @style.theme }#{ width }.css"

    banner: ->
      width:  770 # 458  580  770
      height: 161 # 112  161  161

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

