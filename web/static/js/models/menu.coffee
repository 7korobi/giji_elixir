{ Collection, Model, Query, Rule } = require "memory-record"
{ InputTie } = require "mithril-tie"
Collection.store.merge
  menu:  { current: "menu" }
  site:  { current: "top"  }
  width: { current: "full" }
  pop:   { current: false, type: "Bool" }
  theme: { current: "cinema" }
  font:  { current: "normal" }

new Rule("menu").schema ->
  @order "order"
  @tree()

  @scope (all)->
    all.icons = ({menu, site, width}, options)->
      { list } = all.show menu, site, width
      list.push all.find menu
      list.map ({_id})-> Model.menu.menu.item _id, options

    show: (menu, site, width)->
      all.find(menu).nodes(1).in({ site, width }).where (o)-> ! o.disabled

  class @model extends @model
    @set_tie: (@tie)->
      { params } = @tie
      @tie.stay = (id, value)->
        params.pop = ! params.pop

      @tie.change = (id, value, old)->
        { params } = Model.menu.tie
        if "menu" == id
          params.pop = true
          menu = Query.menus.find(value)
          menu.onselect? params
      @tie.action = ->
        console.log ["action"]

      @pop = @tie.bundle
        _id: "pop"
        attr:
          type: "checkbox"
        current: false
      @menu = @tie.bundle
        _id: "menu"
        attr:
          type: "icon"
        current: "menu"
        options: Query.menus.hash
        option_default:
          label: "icon default"
      @site = @tie.bundle
        _id: "site"
        attr:
          type: "hidden"
        current: "top"
      @width = @tie.bundle
        _id: "width"
        attr:
          type: "hidden"
        current: "full"
      @theme = @tie.bundle
        _id: "theme"
        attr:
          type: "btns"
        current: "cinema"
      @font = @tie.bundle
        _id: "font"
        attr:
          type: "btns"
        current: "normal"

    @map_reduce: (o, emit)->
    constructor: ->
      [menu_id..., @icon] = @_id.split(",")
      @menu_id = menu_id.join(",")
      @width ?= ["normal", "full"]
      @site ?= ["top", "user", "book"]

Collection.menu.set
  "menu,calc,cog":
    order: 1
    label: "画面表示を調整します。"

  "menu,calc,bike":
    disabled: true
    order: 2
    site: ["top"]
    label: "便利ツール。"

  "menu,calc,clock":
    disabled: true
    order: 3
    site: ["user"]
    label: ""

  "menu,calc,search":
    order: 4
    site: ["user", "book"]
    label: "発言中の言葉を検索します。"


  "menu,resize-full":
    order: 10
    site: ["top", "user"]
    width: ["normal"]
    label: "便利ツール。"
    onselect: (params)->
      params.menu = @menu._id
      params.width = "full"

  "menu,resize-normal":
    order: 10
    site: ["top", "user"]
    width: ["full"]
    label: "便利ツール。"
    onselect: (params)->
      params.menu = @menu._id
      params.width = "normal"

  "menu,calc":
    order: 11
    label: "便利ツール。"


  "menu":
    order: 99999
    label: ""
    badge: -> 0


  "menu,pin":
    order: 12
    site: ["book"]
    label: "ピン止めを表示します。"
    badge: ->
      # doc.messages.pins(Url.prop).list.length - Mem.Query.events.list.length
      0

  "menu,home":
    order: 13
    site: ["user", "book"]
    label: "村の設定、ルール、メモを表示します。"
    badge: ->
      # Mem.Query.messages.home("announce").list.length - Mem.Query.events.list.length
      0

  "menu,mail":
    disabled: true
    order: 14
    site: ["user", "book"]
    label: "秘密の発言、私信を表示します。"
    badge: -> 0

  "menu,chat-alt":
    order: 15
    site: ["book"]
    label: "発言を表示します。"
    badge: ->
      prop = _.merge {}, Url.prop,
        talk: -> "all"
        open: -> true
        search: -> ""
      # doc.messages.talk(prop).list.length - Mem.Query.events.list.length
      0

  "menu,pin,comment":
    order: 100
    site: ["book"]
    label: "公開発言します。"

  "menu,home,comment":
    order: 100
    site: ["book"]
    label: "メモを更新します。"

  "menu,mail,comment":
    order: 100
    site: ["book"]
    label: "内緒話をします。"

  "menu,chat-alt,comment":
    order: 100
    site: ["book"]
    label: "公開発言します。"

