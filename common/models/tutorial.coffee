"use strict"

Hope     = require("zenserver").Hope
Schema   = require("zenserver").Mongoose.Schema
db       = require("zenserver").Mongo.connections.primary

Tutorial = new Schema
  chapter    : type: Number
  subchapter : type: Number
  title      : type: String
  readme     : type: String
  yaml       : type: String
  code       : type: String

# -- Static methods ------------------------------------------------------------
Tutorial.statics.register = (parameters) ->
  promise = new Hope.Promise()
  tutorial = db.model "Tutorial", Tutorial
  new tutorial(parameters).save()
  promise

Tutorial.statics.search = (query, limit = 0) ->
  promise = new Hope.Promise()
  @find(query).limit(limit).exec (error, value) ->
    if limit is 1 and not error
      error = code: 402, message: "Tutorial not found." if value.length is 0
      value = value[0]
    promise.done error, value
  promise

# -- Instance methods ----------------------------------------------------------
Tutorial.methods.parse = ->
  id         : @_id
  chapter    : @chapter
  subchapter : @subchapter
  title      : @title
  readme     : @readme
  yaml       : JSON.parse @yaml
  code       : JSON.parse @code

exports = module.exports = db.model "Tutorial", Tutorial
