{ Query } = require "memory-record"

module.exports =
  metaInfo: ->
    title: @current.title
    titleTemplate: '%s - 人狼議事'
    meta: [
      { name: "apple-mobile-web-app-capable", content: "yes" }
      { name: "apple-mobile-web-app-status-bar-style", content: "black-translucent" }
      { name: "format-detection", content: "telephone=no" }
    ]
    script: [
      { src: "https://use.fontawesome.com/6348868528.js"}
    ]

  data: ->
    current: Query.folders.hash[@$route.name] ? Query.folders.hash.PERJURY

  computed:
    hello_ids: ->
      Query.chats.for_part("#{@current.rule}-top").ids

    query: ->
      query = {}
      for key, val of @$route.query
        query[key] = val
      query.css = @css
      query

