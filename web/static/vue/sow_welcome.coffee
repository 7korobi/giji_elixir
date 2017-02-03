{ Query } = require "memory-record"

file = (path)->
  "http://s3-ap-northeast-1.amazonaws.com/giji-assets" + path

bg = (name)->
  file "/images/bg/#{name}"

class_name =
  "480-width":   "std-width"
  "800-width":  "wide-width"
  "1200-width": "full-width"

module.exports =
  metaInfo: ->
    link: [
      { href: "mailto:7korobi@gmail.com" }
      { rel: 'stylesheet', type: 'text/css', href: @style_url }
    ]
    bodyAttrs:
      class: @body_class

  data: ->
    css = @$route.query.css ? "cinema800"
    [..., theme, width = 800] = css.match(/^(\D+)(\d*)$/)

    layoutfilter: !!(@$cookie.get("layoutfilter") - 0)
    current: Query.folders.host(location?.hostname).list.first ? Query.folders.hash.LOBBY
    style: { theme, width }
    use: {}
    mode: window?.welcome_navi
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
      switch @style.theme
        when "ririnra"
          @style.width = 800
      list =
        for k,v of @style
          s = "#{v}-#{k}"
          class_name[s] ? s
      list.join(" ")

    welcome_style: ->
      backgroundPosition: "left 50% top #{ -@y / 2 }px"

    filmend_url: ->
      switch @style.theme
        when "wa"
          bg "film-wa-end.png"
        else
          bg "film-end.png"

    css: ->
      { theme, width } = @style
      @use.theme?.unuse()
      @use.theme = require "~styl/theme-#{theme}.styl.use"
      @use.theme.use()
      switch @style.theme
        when "ririnra"
          @style.width = 800
          "#{ theme }"
        else
          "#{ theme }#{ width }"

    style_url: ->
      { theme, width } = @style
      @$router.replace { @query }
      file "/stylesheets/#{ @css }.css"

    query: ->
      query = {}
      for key, val of @$route.query
        query[key] = val
      query.css = @css
      query

    current_url: ->
      @current.href + "?css=#{ @css }"

  methods:
    poll: ->
      return unless @active
      @y = window.scrollY
      requestAnimationFrame? @poll

    vils: (id)->
      max_vils = Query.folders.hash[id].max_vils
      if max_vils && "progress" == @export_to
        "#{max_vils}村:"
      else
        ""

    url: (id)->
      switch @export_to
        when "progress"
          Query.folders.hash[id].href
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

