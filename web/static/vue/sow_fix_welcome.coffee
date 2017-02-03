{ Query } = require "memory-record"

file = (path)->
  "http://s3-ap-northeast-1.amazonaws.com/giji-assets" + path

bg = (name)->
  file "/images/bg/#{name}"

color_name =
  "wa":      "white"
  "cinema":  "white"
  "ririnra": "white"
  "moon":    "black"
  "night":   "black"
  "star":    "black"

width_name =
  "mini-msg":   "w458"
  "right-msg":  "w580"
  "center-msg": "w580"
  "game-msg":   "w770"
  "large-msg":  "w770"


style_names = ///
  \s*(speech|white|black|cinema|moon|night|ririnra|star|wa|simple|mobile|pc|\S+-font|\S+-msg)\s*
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
    css       = @$cookie.get("css")       ? "cinema_center-msg_small-font"
    row       = @$cookie.get("row")       ? 100
    msg_style = @$cookie.get("msg_style") ? "pc_asc_50"
    [theme, msg, font] = css.split("_")
    [device, order, row] = msg_style.split("_")

    mode: window?.welcome_navi
    current: Query.folders.host(location?.hostname).first ? Query.folders.hash.LOBBY
    style: { theme, msg, font, device, order, row }
    use: {}
    now: Date.now()
    export_to: "progress"
    active: true
    y: 0
    cog: false

  created: ->
    if window?
      @poll()

  destroyed: ->
    @active = false

  computed:
    body_class: ->
      { theme, msg, font, device, order, row } = @style
      color = color_name[theme]
      width = width_name[msg]

      @use.theme?.unuse()
      @use.theme = require "~styl/theme-#{theme}.styl.use"
      @use.theme.use()

      @$cookie.set "css", [theme, msg, font].join("_"),
        path: '/'
        expires: '7D'

      @$cookie.set "row", [row].join("_"),
        path: '/'
        expires: '7D'

      @$cookie.set "msg_style", [device,order,row].join("_"),
        path: '/'
        expires: '7D'

      header = document?.querySelector("html")?.className?.replace(style_names, "") ? ""
      header + " #{color} #{theme} #{theme}-theme #{msg} #{width} #{font} #{device}"

    welcome_style: ->
      backgroundPosition: "left 50% top #{ -@y / 2 }px"

    filmend_url: ->
      switch @style.theme
        when "wa"
          bg "film-wa-end.png"
        else
          bg "film-end.png"

    query: ->
      query = {}
      for key, val of @$route.query
        query[key] = val
      query.css = @css
      query

    current_url: ->
      @current.route.path + "?css=#{ @css }"

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

