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
  "menu,calc":
    order: 2
    enable: false
    label: "便利ツール。"

  "menu,calc,cog":
    order: 1
    enable: true
    label: "画面表示を調整します。"

  "menu,calc,clock":
    order: 2
    enable: false
    site: ["user"]
    label: ""

  "menu,calc,search":
    order: 3
    enable: true
    site: ["user", "book"]
    label: "発言中の言葉を検索します。"


  "menu":
    order: 99999
    enable: true
    label: ""


  "menu,bike":
    order: 1
    enable: false
    site: ["top"]
    label: "便利ツール。"


  "menu,resize-full":
    order: 3
    enable: true
    site: ["top", "user"]
    mode: ["normal"]
    label: "便利ツール。"

  "menu,resize-normal":
    order: 3
    enable: true
    site: ["top", "user"]
    mode: ["full"]
    label: "便利ツール。"


  "menu,pin":
    order: 10
    enable: true
    site: ["book"]
    label: "ピン止めを表示します。"

  "menu,home":
    order: 11
    enable: true
    site: ["user", "book"]
    label: "村の設定、ルール、メモを表示します。"

  "menu,mail":
    order: 12
    enable: false
    site: ["user", "book"]
    label: "秘密の発言、私信を表示します。"

  "menu,chat-alt":
    order: 13
    enable: true
    site: ["book"]
    label: "発言を表示します。"

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

