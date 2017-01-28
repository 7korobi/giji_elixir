{ Query } = require "memory-record"

file = (path)->
  "http://s3-ap-northeast-1.amazonaws.com/giji-assets" + path

bg = (name)->
  file "/images/bg/#{name}"

style_names = ///
  \s*\S+-(theme|width|layout|font)\s*
///g

module.exports =
  metaInfo: ->
    link: [
      { href: "mailto:7korobi@gmail.com" }
      { rel: 'stylesheet', type: 'text/css', href: @style_url }
    ]
    htmlAttrs:
      class: @body_class

  data: ->
    css = @$cookie.get("css") ? "cinema~wide~center~std"
    [theme, width, layout, font] = css.split("~")
    mode: window?.welcome
    current: Query.folders.hash[@$route.name] ? Query.folders.hash.PERJURY
    style: { theme, width, layout, font }
    use: {}
    now: Date.now()
    export_to: "progress"
    active: true
    y: 0

  created: ->
    if window?
      @poll()

  destroyed: ->
    @active = false

  computed:
    body_class: ->
      { theme, width, layout, font } = @style
      @use.theme?.unuse()
      @use.theme = require "~styl/theme-#{theme}.styl.use"
      @use.theme.use()
      str = [theme, width, layout, font].join("~")
      @$cookie.set "css", str,
        path: '/'
        expires: '7D'

      header = document?.querySelector("html")?.className?.replace(style_names, "") ? ""
      list =
        for k,v of @style
          "#{v}-#{k}"
      header + " " +list.join(" ")

    welcome_style: ->
      backgroundPosition: "right 0px top #{ -@y / 2 }px"

    filmend_url: ->
      switch @style.theme
        when "wa"
          bg "film-wa-end.png"
        else
          bg "film-end.png"

  methods:
    poll: ->
      return unless @active
      @y = window.scrollY
      requestAnimationFrame? @poll

    slide: (to)->
      @export_to = to

    vils: (id)->
      max_vils = Query.folders.hash[id].max_vils
      if max_vils && "progress" == @export_to
        "#{max_vils}村:"
      else
        ""

    url: (id)->
      switch @export_to
        when "progress"
          Query.folders.hash[id].route?.path
        when "finish"
          file "/stories/all?folder=#{id}"

  components:
    sow:
      functional: true
      props: ["folder", "export_to"]
      render: (m, ctx)->
        { export_to, folder } = ctx.props
        children = ctx.children ? [ folder.toLowerCase() ]

        vils = ctx.parent.vils folder
        href = ctx.parent.url  folder

        m "p", [
          vils
          m "a",{ attrs: { href }}, children
        ]

