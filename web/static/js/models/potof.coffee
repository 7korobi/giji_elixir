{ Collection, Model, Query, Rule } = require "memory-record"

new Rule("potof").schema ->
  @order "write_at"
  @belongs_to "book"
  @belongs_to "part"
  @belongs_to "face"

  @scope (all)->
    {}

  class @model extends @model
    constructor: ->
      @_id = @id
      console.warn @
