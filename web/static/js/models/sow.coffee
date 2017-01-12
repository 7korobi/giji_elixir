{ Collection, Model, Query, Rule } = require "memory-record"

new Rule("folder").schema ->
  @scope (all)->
    enable: all.where (o)-> ! o.disabled

  class @model extends @model
    constructor: ->
      @max_vils = @config?.cfg?.MAX_VILLAGES
      @disabled = ! @max_vils
      @max_vils = 0 if "LOBBY" == @folder

      return if @disabled
      path = @config.cfg.URL_SW + "/sow.cgi"
      @disabled = ! path
      @route = { path, name: @folder }

Collection.folder.set  require "../yaml/sow_folder.yml"

