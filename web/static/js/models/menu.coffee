{ Collection, Model, Query, Rule } = require "memory-record"

new Rule("menu").schema ->
  @order "order"
  @tree()

  @scope (all)->
    show: (id, site, mode)->
      all.find(id).nodes(1).where(enable: true).in { site, mode }

  class @model extends @model
    @map_reduce: (o, emit)->
    constructor: ->
      [menu_id..., @icon] = @_id.split(",")
      @menu_id = menu_id.join(",")
      @mode ?= ["normal", "full"]
      @site ?= ["top", "user", "book"]

Collection.menu.set
  "menu,calc,cog":
    order: 1
    enable: true
    label: "画面表示を調整します。"

  "menu,calc,bike":
    order: 2
    enable: false
    site: ["top"]
    label: "便利ツール。"

  "menu,calc,clock":
    order: 3
    enable: false
    site: ["user"]
    label: ""

  "menu,calc,search":
    order: 4
    enable: true
    site: ["user", "book"]
    label: "発言中の言葉を検索します。"


  "menu,resize-full":
    order: 10
    enable: true
    site: ["top", "user"]
    mode: ["normal"]
    label: "便利ツール。"

  "menu,resize-normal":
    order: 10
    enable: true
    site: ["top", "user"]
    mode: ["full"]
    label: "便利ツール。"

  "menu,calc":
    order: 11
    enable: true
    label: "便利ツール。"


  "menu":
    order: 99999
    enable: true
    label: ""
    badge: -> 0


  "menu,pin":
    order: 12
    enable: true
    site: ["book"]
    label: "ピン止めを表示します。"
    badge: -> 0

  "menu,home":
    order: 13
    enable: true
    site: ["user", "book"]
    label: "村の設定、ルール、メモを表示します。"
    badge: -> 0

  "menu,mail":
    order: 14
    enable: false
    site: ["user", "book"]
    label: "秘密の発言、私信を表示します。"
    badge: -> 0

  "menu,chat-alt":
    order: 15
    enable: true
    site: ["book"]
    label: "発言を表示します。"
    badge: -> 0

  "menu,pin,comment":
    order: 100
    enable: true
    site: ["book"]
    label: "公開発言します。"

  "menu,home,comment":
    order: 100
    enable: true
    site: ["book"]
    label: "メモを更新します。"

  "menu,mail,comment":
    order: 100
    enable: true
    site: ["book"]
    label: "内緒話をします。"

  "menu,chat-alt,comment":
    order: 100
    enable: true
    site: ["book"]
    label: "公開発言します。"

