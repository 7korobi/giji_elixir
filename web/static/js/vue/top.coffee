{ Query } = require "memory-record"

file = (path)->
  "http://giji-assets.s3-website-ap-northeast-1.amazonaws.com" + path

module.exports =
  metaInfo: ->
    title: @current.title
    titleTemplate: '%s - 人狼議事'
    meta: [
      { charset: "utf-8" }
#      { name: 'Author',   content: '7korobi@gmail.com' }
#      { name: 'viewport', content: 'width=device-width, initial-scale=1.0' }
      { name: "apple-mobile-web-app-capable", content: "yes" }
      { name: "apple-mobile-web-app-status-bar-style", content: "black-translucent" }
      { name: "format-detection", content: "telephone=no" }
    ]
    link: [
      { href: "mailto:7korobi@gmail.com" }
      { rel: 'stylesheet', type: 'text/css', href: @style_url }
    ]
    changed: (newInfo, append, remove)->
      console.log { append, remove }

  data: ->
    current: Query.folders.hash.LOBBY
    mode: "progress"
    style:
      theme: "cinema"
      width: 800
    now: new Date - 0

  created: ->
    css = @$route.query.css ? @$cookie.get("css") ? "cinema800"
    [..., theme, width] = css.match(/^(\D+)(\d+)$/)
    @style = { theme, width }
    @current = Query.folders.hash[@$route.name] ? @current

  computed:
    welcome_ids: ->
      Query.chats.for_part("#{@current._id}-Welcome").ids
    banner_url: -> file "/images/banner/title#{ @banner.width }lupino.png"
    css: ->
      switch @style.theme
        when "ririnra"
          width = ""
        else
          width = @style.width
      "#{ @style.theme }#{ width }"

    style_url: ->
      @$cookie.set "css", @css,
        path: '/'
        expires: '7D'
      @$router.replace
        query: { @css }
      file "/stylesheets/#{ @css }.css"

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

