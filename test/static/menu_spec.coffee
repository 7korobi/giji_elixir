_ = require "lodash"
m = require "mithril"
{ Collection, Model, Query, Rule } = require "memory-record"
{ InputTie, WebStore, deploy } = require "mithril-tie"
deploy
  window:
    scrollX: 0
    scrollY: 0
    devicePixelRatio: 2

WebStore.maps
  session: ["menu", "site", "mode"]

component =
  controller: ->
    Model.menu.set_tie tie = InputTie.form WebStore.params, []
    return

  view: ->
    { tie } = Model.menu
    tie.draw()

    m ".menus",
      Query.menus.icons tie.params, tag: "menuicon"
      Query.menus.icons tie.params, tag: "bigicon"

target "models/menu.coffee"

describe "Query.menus", ->
  c = new component.controller()
  it "data structure.", ->
    params =
      menu: "menu"
      site: "top"
      mode: "normal"
    assert.deepEqual Query.menus.show(params).pluck("icon"), ["resize-full", "calc"]
    params =
      menu: "menu"
      site: "top"
      mode: "full"
    assert.deepEqual Query.menus.show(params).pluck("icon"), ["resize-normal", "calc"]
    params =
      menu: "menu"
      site: "user"
      mode: "normal"
    assert.deepEqual Query.menus.show(params).pluck("icon"), ["resize-full", "calc", "home"]
    params =
      menu: "menu"
      site: "book"
      mode: "normal"
    assert.deepEqual Query.menus.show(params).pluck("icon"), ["calc", "pin","home","chat-alt"]
    params =
      menu: "menu,home"
      site: "book"
      mode: "normal"
    assert.deepEqual Query.menus.show(params).pluck("icon"), ["comment"]

  it "params structure.", ->
    assert.deepEqual Query.stores.hash,
      menu: { _id: "menu", type: "String", current: "menu" }
      site: { _id: "site", type: "String", current: "top"  }
      mode: { _id: "mode", type: "String", current: "full" }

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
      menu: "menu"
      mode: "full"
      site: "top"

    tie.do_change tie.input.menu, "menu,resize-normal"
    component.view c

    assert.deepEqual tie.params,
      menu: "menu"
      mode: "normal"
      site: "top"

    tie.do_change tie.input.menu, "menu,home"
    component.view c

    assert.deepEqual tie.params,
      menu: "menu,home"
      mode: "normal"
      site: "top"

