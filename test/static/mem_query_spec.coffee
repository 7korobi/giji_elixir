{ Collection, Model, Query, Rule } = require "memory-record"

target "models/chr.coffee"

describe "Query.faces", ->
  it "bye jelemy", ->
    assert Query.faces.find("c06") == undefined

  it "symon",
    assert.deepEqual Query.faces.find("c99").chr_jobs.list[0], Query.chr_jobs.find("ririnra_c99")
    assert.deepEqual Query.faces.find("c99").chr_jobs.list[1], Query.chr_jobs.find("animal_c99")

describe "Query.chr_jobs", ->
  it "order", ->
    assert Query.chr_jobs.face("c10").pluck "chr_set_idx" == [0,2,7,8]
    assert Query.chr_jobs.face("c83").pluck "chr_set_idx" == [0,4,7,8]

  it "zoy",
    assert Query.chr_jobs.face("c10").list[0], Query.chr_jobs.find("ririnra_c10")
    assert Query.chr_jobs.face("c10").list[1], Query.chr_jobs.find("time_c10")

  it "iris",
    assert Query.chr_jobs.face("c83").list[0], Query.chr_jobs.find("ririnra_c83")
    assert Query.chr_jobs.face("c83").list[1], Query.chr_jobs.find("mad_c83")

