{ Collection, Model, Query, Rule } = require "memory-record"
{ InputTie } = require "mithril-tie"
Collection.store.merge
  menu: { current: "menu" }
  site: { current: "top"  }
  mode: { current: "full" }

new Rule("menu").schema ->
  @order "order"
  @tree()

  @scope (all)->
    show: ({menu, site, mode})->
      all.find(menu).nodes(1).in({ site, mode }).where (o)-> ! o.disabled

    icons: (params, options)->
      { list } = all.show(params)
      list.push @
      list.map ({_id})-> Model.menu.menu.item _id, options

  class @model extends @model
    @set_tie: (@tie)->
      @tie.stay = (id, value)->
        console.log ["stay", id, value]
      @tie.change = (id, value, old)->
        if "menu" == id
          menu = Query.menus.find(value)
          menu.onselect?()
        console.log ["change", id, value, old]
      @tie.action = ->
        console.log ["action"]

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
      @mode = @tie.bundle
        _id: "mode"
        attr:
          type: "hidden"
        current: "full"

    @map_reduce: (o, emit)->
    constructor: ->
      [menu_id..., @icon] = @_id.split(",")
      @menu_id = menu_id.join(",")
      @mode ?= ["normal", "full"]
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
    mode: ["normal"]
    label: "便利ツール。"
    onselect: ->
      { tie } = Model.menu
      tie.params.mode = "full"
      tie.do_change tie.input.menu, @menu._id

  "menu,resize-normal":
    order: 10
    site: ["top", "user"]
    mode: ["full"]
    label: "便利ツール。"
    onselect: ->
      { tie } = Model.menu
      tie.params.mode = "normal"
      tie.do_change tie.input.menu, @menu._id

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
    badge: -> 0

  "menu,home":
    order: 13
    site: ["user", "book"]
    label: "村の設定、ルール、メモを表示します。"
    badge: -> 0

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
    badge: -> 0

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
