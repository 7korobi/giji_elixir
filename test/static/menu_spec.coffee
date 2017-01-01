_ = require "lodash"
m = require "mithril"
{ Collection, Model, Query, Rule } = require "memory-record"
{ InputTie, deploy } = require "mithril-tie"
deploy
  window:
    scrollX: 0
    scrollY: 0
    devicePixelRatio: 2

class InputTie.type.icon extends InputTie.type.icon
  option_default:
    className: ""
    label: ""
    "data-tooltip":　"選択しない"

  option: (value)->
    hash = @options.hash ? @options ? {}
    hash[value] ? @option_default

  with: (value, mode)->
    bool = @__value == value

    switch mode
      when bool
        @_with[value]()
      when ! bool
        null
      else
        # define mode function.
        @_with = {}
        @_with[value] = mode

  item: (value, m_attr = {})->
    option = @option value
    tag = m_attr.tag || "menuicon"

    ma = @_attr @attr, m_attr, option,
      className: [@attr.className, m_attr.className, option.className].join(" ")
      selected: value == @__value
      value:    value
    # data-tooltip, disabled
    tags[tag] value, ma, option

  menuicon = (id, attr, { icon = id, badge })->
    m "a.menuicon", attr,
      m "span.icon-#{icon}"
      m ".emboss.pull-right", badge() if badge

  bigicon = (id, attr, { icon = id, badge })->
    m "section", attr,
      m ".bigicon",
        m "span.icon-#{icon}"
      m ".badge.pull-right", badge() if badge
  tags = { menuicon, bigicon }


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
        options: Query.menus.hash
        option_default:
          label: "icon default"
    ]
    return

  view: ({tie})->
    icons = Query.menus.show "menu,home", "book", "normal"
    tie.draw()

    m ".menus",
      for {_id} in icons.list
        tie.input.icon.item _id, tag: "menuicon"
      tie.input.icon.item "menu,home", tag: "menuicon"

      for {_id} in icons.list
        tie.input.icon.item _id, tag: "bigicon"
      tie.input.icon.item "menu,home", tag: "bigicon"


target "models/menu.coffee"

describe "Query.menus", ->
  it "data structure.", ->
    assert.deepEqual Query.menus.show("menu", "top", "normal").pluck("icon"), ["resize-full", "calc"]
    assert.deepEqual Query.menus.show("menu", "top", "full").pluck("icon"), ["resize-normal", "calc"]
    assert.deepEqual Query.menus.show("menu", "user", "normal").pluck("icon"), ["resize-full", "calc", "home"]
    assert.deepEqual Query.menus.show("menu", "book", "normal").pluck("icon"), ["calc", "pin","home","chat-alt"]
    assert.deepEqual Query.menus.show("menu,home", "book", "normal").pluck("icon"), ["comment"]

  it "shows menu buttons", ->
    { tie } = c = new component.controller()
    component.view c

    assert.deepEqual tie.input.icon.option("menu,calc,cog"),  Query.menus.find("menu,calc,cog")
    assert.deepEqual tie.input.icon.option("menu,home"), Query.menus.find("menu,home")

    assert.deepEqual tie.input.icon.item("menu").children[1].children, [0]

    assert tie.input.icon.item("menu"                ).tag == "a"
    assert tie.input.icon.item("menu", tag:"menuicon").tag == "a"
    assert tie.input.icon.item("menu", tag:"bigicon" ).tag == "section"
