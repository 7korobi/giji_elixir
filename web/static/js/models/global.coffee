{ Collection, Query } = require "memory-record"
{ Url, WebStore } = require "mithril-tie"

Collection.store.merge
  menu:  { current: "menu" }
  site:  { current: "top"  }
  width: { current: "full" }
  pop:   { current: false, type: "Bool" }
  theme: { current: "cinema" }
  font:  { current: "std" }

Url.define = (key)->
    Query.stores.hash[key]

Url.maps
  search:
    css: "css=:theme~:width"

WebStore.maps
  session: ["menu", "site", "font"]
