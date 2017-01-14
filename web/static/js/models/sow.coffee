{ Collection, Model, Query, Rule } = require "memory-record"

new Rule("folder").schema ->
  @scope (all)->
    enable: all.where (o)-> ! o.disabled

  class @model extends @model
    constructor: ->
      if o = @config?.cfg?
        @title    = o.NAME_HOME
        @max_vils = o.MAX_VILLAGES
        path = @config.cfg.URL_SW + "/sow.cgi"

      switch @folder
        when "LOBBY"
          @max_vils = 0

      return if @disabled = ! path
      @route = { path, name: @folder }

Collection.folder.set  require "../yaml/sow_folder.yml"

