_ = require "lodash"
m = require "mithril"
{ Collection, Model, Query, Rule } = require "memory-record"
{ InputTie, deploy } = require "mithril-tie"
deploy
  window:
    scrollX: 0
    scrollY: 0
    devicePixelRatio: 2


_pick = (attrs, last)->
  _.assignIn {}, attrs..., last

c_icon  = (bool, new_val)-> if bool then null else new_val

class btn_input extends InputTie.type.hidden
  _attr: ( attrs..., last )->
    { _id, tie } = b = @
    { className, disabled, selected, value, target } = last
    onchange = ->
      return if b.timer
      b._debounce()
      .catch ->
        b.timer = null
      value = b._value selected, value, target
      tie.do_change b, value, ma
      tie.do_fail   b, value, ma unless b.dom.validity.valid

    css = "btn"
    css += " edge" unless disabled || tie.disabled
    css += " active" if selected
    css += " " + className if className

    ma = _pick attrs,
      config: @__config
      className: css
      onclick: onchange
      onmouseup: onchange
      ontouchend: onchange

  do_change: (value)->
    { pattern, required } = @attr

    if @dom
      if required && ! value
        error = "このフィールドを入力してください。"

      if pattern && value.match new Regexp pattern
        error = "指定されている形式で入力してください。"

      @error error
    super

  head: (m_attr = {})->
    { name } = @format

    ma = @_attr_label m_attr
    m "h6", ma, name

class InputTie.type.icon extends btn_input
  _value: c_icon
  option_default:
    className: ""
    label: ""
    "data-tooltip":　"選択しない"

  field: (m_attr = {})->
    throw "not implement"

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


target "models/menu.coffee"

describe "Query.menus", ->
  it "data structure.", ->
    assert.deepEqual Query.menus.show("menu", "top", "normal").pluck("icon"), ["resize-full", "calc"]
    assert.deepEqual Query.menus.show("menu", "top", "full").pluck("icon"), ["resize-normal", "calc"]
    assert.deepEqual Query.menus.show("menu", "user", "normal").pluck("icon"), ["resize-full", "calc", "home"]
    assert.deepEqual Query.menus.show("menu", "book", "normal").pluck("icon"), ["calc", "pin","home","chat-alt"]
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
            options: Query.menus.hash
            option_default:
              label: "icon default"
        ]
        return

      view: ({tie})->
        tie.draw()

    { tie } = c = new component.controller()
    component.view c

    assert.deepEqual tie.input.icon.option("menu,calc,cog"),  Query.menus.find("menu,calc,cog")
    assert.deepEqual tie.input.icon.option("menu,home"), Query.menus.find("menu,home")

    assert.deepEqual tie.input.icon.item("menu").children[1].children, [0]

    assert tie.input.icon.item("menu,cog"                ).tag == "a"
    assert tie.input.icon.item("menu,cog", tag:"menuicon").tag == "a"
    assert tie.input.icon.item("menu,cog", tag:"bigicon" ).tag == "section"
