{ Collection, Model, Query, Rule } = require "memory-record"

new Rule("phase").schema ->
  @order "write_at"
  @belongs_to "book"
  @belongs_to "part"

  @scope (all)->
    {}

  class @model extends @model
    constructor: ->
      [book_id, part_idx, @idx] = @id.split('-')
      @_id     = @id
      @part_id = [book_id, part_idx].join('-')
      console.warn @
