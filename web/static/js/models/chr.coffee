{ Collection, Model, Query, Rule } = require "memory-record"

new Rule("face").schema ->
  @has_many "chr_jobs"
  @has_many "chr_npcs"

  @order "order"
  @scope (all)->
    tag: (tag_id)->
      switch tag_id
        when "all"
          all
        else
          all.in tags:tag_id

    chr_jobs: (chr_job_id)->
      all.where {chr_job_id}

    name_head: ->
      counts = []
      for idx in ["ア".charCodeAt(0) .. "ン".charCodeAt(0)]
        key = String.fromCharCode idx
        names = all.where(name:///^#{key}///).pluck "name"
        counts[names.length] ?= []
        counts[names.length].push "<#{key}>#{names.join(" ")}"
      counts

  map =
    count: 1
  class @model extends @model
    @map_reduce: (o, emit)->
      emit "all", "all", map
      for tag in o.tags
        emit "tag", tag, map


new Rule("chr_set").schema ->
  @order "label"
  @has_many "chr_jobs"
  @has_many "chr_npcs"


new Rule("chr_npc").schema ->
  @order "label"
  @belongs_to "chr_set", dependent: true
  @belongs_to "face",    dependent: true


new Rule("chr_job").schema ->
  @order "face.order"
  @belongs_to "chr_set", dependent: true
  @belongs_to "face",    dependent: true

  @scope (all)->
    face: (face_id)->
      all.where({ face_id }).sort "chr_set_idx"

  class @model extends @model
    constructor: ->
      @chr_job_id = @_id
      @chr_set_idx = order.indexOf @chr_set_id


order = [
  "ririnra"
  "wa"
  "time"
  "sf"
  "mad"
  "ger"
  "changed"
  "animal"
  "school"
  "all"
]

Collection.face.set require "../yaml/face.yml"
for key in order
  data = require "../yaml/cs_#{key}.yml"
  Collection.chr_set.merge data.chr_set
  Collection.chr_npc.merge data.chr_npc
  Collection.chr_job.merge data.chr_job


list =
  for face in Query.faces.list
    chr_set_id = "all"
    face_id = face._id
    _id = "all_#{face_id}"
    job = Query.chr_jobs.face(face_id).list.first?.job
    continue unless job?
    { chr_set_id, face_id, job, _id }

Collection.chr_job.merge list
