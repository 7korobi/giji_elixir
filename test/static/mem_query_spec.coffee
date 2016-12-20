require "./_helper.coffee"
{ Collection, Model, Query, Rule } = require "memory-record"

target "models/chr.coffee"

describe "Query.faces", ->
  it "bye jelemy", ->
    assert Query.faces.find("c06") == undefined
  it "symon", ->
    console.warn Query.faces.find("c99").chr_jobs.list
    assert Query.faces.find("c99").chr_jobs.list[1].job == "しんかいぎょ"
    assert Query.faces.find("c99").chr_jobs.list[1].chr_set_idx == 7
    assert Query.faces.find("c99").chr_jobs.list[1].chr_set_id == "animal"

  its "symon",
    Query.faces.find("c99").chr_jobs.list
    [
      chr_set_idx: 0
      job: "厭世家"
      chr_set_id: "ririnra"
    ,
      chr_set_idx: 7
      job: "しんかいぎょ"
      chr_set_id: "animal"
    ]

describe "Query.chr_jobs", ->
  it "order", ->
    assert Query.chr_jobs.face("c10").pluck "chr_set_idx" == [0,2,7,8]
    assert Query.chr_jobs.face("c83").pluck "chr_set_idx" == [0,4,7,8]

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