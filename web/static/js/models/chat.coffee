{ Collection, Model, Query, Rule } = require "memory-record"

new Rule("chat").schema ->
  @order "write_at"
  @belongs_to "book"
  @belongs_to "part"
  @belongs_to "phase"
  @belongs_to "potof"

  @scope (all)->
    {}

  class @model extends @model
    @map_reduce: (o, emit)->
      emit "section", o.section_id,
        min: o.open_at
        max: o.write_at

    constructor: ->
      [book_id, part_idx, phase_idx, @idx] = @id.split('-')
      [                  ..., section_idx] = @section_id.split('-')
      @_id      = @id
      @part_id  = [book_id, part_idx].join('-')
      @phase_id = [book_id, part_idx, phase_idx].join('-')
      console.warn @
