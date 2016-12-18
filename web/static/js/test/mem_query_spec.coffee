{ Collection, Model, Query, Rule } = require "memory-record"
require "../models/chr.coffee"

describe "Query.faces", ->
  it "bye jelemy", ->
    expect( Query.faces.find("c06") ).to.eq undefined
  its "symon",
    Query.faces.find("c99").chr_jobs.list
    [
      chr_set_idx: 7
      job: "しんかいぎょ"
      chr_set_id: "animal"
    ,
      chr_set_idx: 0
      job: "厭世家"
      chr_set_id: "ririnra"
    ]

describe "Query.chr_jobs", ->
  it "order", ->
    expect( Query.chr_jobs.face("c10").pluck "chr_set_idx" ).to.deep.eq [0,2,7,8]
    expect( Query.chr_jobs.face("c83").pluck "chr_set_idx" ).to.deep.eq [0,4,7,8]

  its "zoy",
    Query.chr_jobs.face("c10").list
    [
      chr_set_idx: 0
      job: "小娘"
      chr_set_id: "ririnra"
      chr_job_id: "ririnra_c10"
      face_id: "c10"
      face:
        name: "ゾーイ"
        face_id: "c10"
    ,
      chr_set_idx: 2
      job: "小銃協会"
      chr_set_id: "time"
      chr_job_id: "time_c10"
      face_id: "c10"
      face:
        name: "ゾーイ"
        face_id: "c10"
    ]

  its "iris",
    Query.chr_jobs.face("c83").list
    [
      chr_set_idx: 0
      job: "受付"
      chr_set_id: "ririnra"
      chr_job_id: "ririnra_c83"
      face_id: "c83"
      face:
        name: "アイリス"
        face_id: "c83"
    ,
      chr_set_idx: 4
      job: "虹追い"
      chr_set_id: "mad"
      chr_job_id: "mad_c83"
      face_id: "c83"
      face:
        name: "アイリス"
        face_id: "c83"
    ]


global.Mem = null