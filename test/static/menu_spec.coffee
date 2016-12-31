{ Collection, Model, Query, Rule } = require "memory-record"
{ InputTie, deploy } = require "mithril-tie"
deploy
  window:
    scrollX: 0
    scrollY: 0
    devicePixelRatio: 2

target "models/menu.coffee"

describe "Query.menus", ->
  it "data structure.", ->
    assert.deepEqual Query.menus.show("menu", "top", "normal").pluck("icon"), ["resize-full"]
    assert.deepEqual Query.menus.show("menu", "top", "full").pluck("icon"), ["resize-normal"]
    assert.deepEqual Query.menus.show("menu", "user", "normal").pluck("icon"), ["resize-full", "home"]
    assert.deepEqual Query.menus.show("menu", "book", "normal").pluck("icon"), ["pin","home","chat-alt"]
    assert.deepEqual Query.menus.show("menu,home", "book", "normal").pluck("icon"), ["comment"]

  it "shows menu buttons", ->
    state = {}
    component =
      controller: ->
        @params = {}
        @tie = InputTie.form @params, []
        @tie.stay = (id, value)->
          state.stay = value
        @tie.change = (id, value, old)->
          state.change = value
        @tie.action = ->
          state.action = true
        @tie.draws ->

        @bundles = [
          @tie.bundle
            _id: "icon"
            attr:
              type: "icon"
            name: "アイコン"
            current: null
            options:
              cog:   "画面表示を調整します。"
              home:  "村の設定、アナウンスを表示します。"
            option_default:
              label: "icon default"
        ]
        return

      view: ({tie})->
        tie.draw()

    { tie } = c = new component.controller()
    component.view c

    assert_only tie.input.icon.option("cog"),
      _id: "cog"
      label: "画面表示を調整します。"

    assert_only tie.input.icon.option("home"),
      _id: "home"
      label: "村の設定、アナウンスを表示します。"

    assert_only tie.input.icon.option(null),
      label: "icon default"
      "data-tooltip": "選択しない"

    tie.input.icon.options.cog.badge = -> 123
    assert tie.input.icon.item("cog").children[1].children[0] == 123

    assert tie.input.icon.item("cog"                    ).tag == "a"
    assert tie.input.icon.item("cog", { tag:"menuicon" }).tag == "a"
    assert tie.input.icon.item("cog", { tag:"bigicon"  }).tag == "section"
