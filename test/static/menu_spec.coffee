_ = require "lodash"
m = require "mithril"
{ Collection, Model, Query, Rule } = require "memory-record"
{ InputTie, Tie, deploy } = require "mithril-tie"
deploy
  window:
    scrollX: 0
    scrollY: 0
    devicePixelRatio: 2

component =
  controller: ->
    Model.menu.set_tie tie = InputTie.form Tie.params, []
    return

  view: ->
    { tie } = Model.menu
    tie.draw()

    m ".menus",
      Query.menus.icons tie.params, tag: "menuicon"
      Query.menus.icons tie.params, tag: "bigicon"

target "models/global.coffee"
target "models/menu.coffee"

describe "Query.menus", ->
  c = new component.controller()
  it "data structure.", ->
    params = ["menu", "top", "std"]
    assert.deepEqual Query.menus.show(params...).pluck("icon"), ["resize-full", "calc"]
    params = ["menu", "top", "full"]
    assert.deepEqual Query.menus.show(params...).pluck("icon"), ["resize-normal", "calc"]
    params = ["menu", "user", "std"]
    assert.deepEqual Query.menus.show(params...).pluck("icon"), ["resize-full", "calc", "home"]
    params = ["menu", "book", "std"]
    assert.deepEqual Query.menus.show(params...).pluck("icon"), ["calc", "pin","home","chat-alt"]
    params = ["menu,home", "book", "std"]
    assert.deepEqual Query.menus.show(params...).pluck("icon"), ["comment"]

  it "shows menu buttons", ->
    component.view c

    { tie } = Model.menu
    assert.deepEqual tie.input.menu.option("menu,calc,cog"),  Query.menus.find("menu,calc,cog")
    assert.deepEqual tie.input.menu.option("menu,home"), Query.menus.find("menu,home")
    assert.deepEqual tie.input.menu.item("menu").children[1].children, [0]

    assert tie.input.menu.item("menu"                ).tag == "a"
    assert tie.input.menu.item("menu", tag:"menuicon").tag == "a"
    assert tie.input.menu.item("menu", tag:"bigicon" ).tag == "section"

  it "sequence", ->
    { tie } = Model.menu
    component.view c
    assert.deepEqual tie.params,
      pop:  false
      menu: "menu"
      width: "full"
      site: "top"
      theme: "cinema"
      font: "std"

    tie.do_change tie.input.menu, "menu,resize-normal"
    component.view c
    assert.deepEqual tie.params,
      pop:  true
      menu: "menu"
      width: "std"
      site: "top"
      theme: "cinema"
      font: "std"

    tie.do_change tie.input.menu, "menu,home"
    component.view c
    assert.deepEqual tie.params,
      pop:  true
      menu: "menu,home"
      width: "std"
      site: "top"
      theme: "cinema"
      font: "std"

    tie.do_change tie.input.menu, "menu,home"
    component.view c
    assert.deepEqual tie.params,
      pop:  false
      menu: "menu,home"
      width: "std"
      site: "top"
      theme: "cinema"
      font: "std"
