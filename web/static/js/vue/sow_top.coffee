{ Query } = require "memory-record"

file = (path)->
  "http://s3-ap-northeast-1.amazonaws.com/giji-assets" + path

bg = (name)->
  file "/images/bg/#{name}"

module.exports =
  metaInfo: ->
    title: @current.title
    titleTemplate: '%s - 人狼議事'
    meta: [
#      { name: 'Author',   content: '7korobi@gmail.com' }
#      { name: 'viewport', content: 'width=device-width, initial-scale=1.0' }
#      { charset: "utf-8" }
      { name: "apple-mobile-web-app-capable", content: "yes" }
      { name: "apple-mobile-web-app-status-bar-style", content: "black-translucent" }
      { name: "format-detection", content: "telephone=no" }
    ]
    link: [
      { href: "mailto:7korobi@gmail.com" }
      { rel: 'stylesheet', type: 'text/css', href: @style_url }
    ]
    bodyAttrs:
      class: @body_class

  data: ->
    css = @$route.query.css ? "cinema800"
    [..., theme, width = 800] = css.match(/^(\D+)(\d*)$/)

    current: Query.folders.hash[@$route.name] ? Query.folders.hash.PERJURY
    style: { theme, width }
    now: Date.now()
    mode: "progress"
    active: true
    y: 0

  created: ->
    if window?
      @poll()

  destroyed: ->
    @active = false

  computed:
    body_class: ->
      switch @style.theme
        when "ririnra"
          @style.width = 800
      ("#{k}-#{v}" for k,v of @style).join(" ")

    welcome_ids: ->
      Query.chats.for_part("#{@current.rule}-top").ids

    welcome_style: ->
      backgroundPosition: "right 0px top #{ -@y / 2 }px"
      backgroundImage: "url(#{bg "fhd-giji.png"})"

    filmend_url: ->
      switch @style.theme
        when "wa"
          bg "film-wa-end.png"
        else
          bg "film-end.png"

    css: ->
      { theme, width } = @style
      switch @style.theme
        when "ririnra"
          @style.width = 800
          "#{ theme }"
        else
          "#{ theme }#{ width }"

    style_url: ->
      @$cookie.set "css", @css,
        path: '/'
        expires: '7D'
      @$router.replace { @query }
      file "/stylesheets/#{ @css }.css"

    query: ->
      query = {}
      for key, val of @$route.query
        query[key] = val
      query.css = @css
      query

  methods:
    poll: ->
      return unless @active
      @y = window.scrollY
      requestAnimationFrame? @poll

    slide: (to)->
      @mode = to

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

