{ Collection, Model, Query, Rule } = require "memory-record"

new Rule("folder").schema ->
  @scope (all)->
    enable: ->
      all.where (o)->
        ! o.disabled

  class @model extends @model
    constructor: ->
      @disabled = ! @config?.cfg?.MAX_VILLAGES

Collection.folder.set  require "../yaml/sow_folder.yml"

###
    max_vage    = Mem.conf.folder.PERJURY.config.cfg.MAX_VILLAGES
    max_crazy   = Mem.conf.folder.CRAZY  .config.cfg.MAX_VILLAGES
    max_xebec   = Mem.conf.folder.XEBEC  .config.cfg.MAX_VILLAGES
    max_ciel    = Mem.conf.folder.CIEL   .config.cfg.MAX_VILLAGES
    max_cafe    = Mem.conf.folder.CABALA .config.cfg.MAX_VILLAGES
    max_morphe  = Mem.conf.folder.MORPHE .config.cfg.MAX_VILLAGES
    max_all     = ( max_vage + max_crazy + max_xebec + max_ciel ) + ( max_cafe + max_morphe )
    max_pan     = Mem.conf.folder.PAN    .config.cfg.MAX_VILLAGES
###

