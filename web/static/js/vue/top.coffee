{ Query } = require "memory-record"

format =
  date: new Intl.DateTimeFormat 'ja-JP',
    year:  "numeric"
    month: "2-digit"
    day:   "2-digit"
    weekday: "short"
    hour:    "2-digit"

  num: new Intl.NumberFormat 'ja-JP',
    style: 'decimal'
    useGrouping: true
    minimumIntegerDigits: 1
    minimumSignificantDigits:  1
    maximumSignificantDigits: 21
    minimumFractionDigits: 0
    maximumFractionDigits: 2


file = (path)->
  "http://giji-assets.s3-website-ap-northeast-1.amazonaws.com" + path

module.exports =
  metaInfo: ->
    title: @current.title
    titleTemplate: '%s トップページ'
    link: [
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
    banner_url: -> file "/images/banner/title#{ @banner.width }lupino.png"
    style_url: ->
      @$cookie.set "css", "#{@style.theme}#{@style.width}",
        expires: '7d'
      console.log "cookie css set."
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
    timeago: (at)->
      format.date.format(at) + "頃"

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

