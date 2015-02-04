"use strict"
Tutorial = require "../common/models/tutorial"


module.exports = (server) ->
  server.post "/tutorial", (request, response) ->
    request.parameters.yaml = JSON.stringify request.parameters.yaml
    Tutorial.register request.parameters
    response.ok()

  server.get "/tutorials", (request, response) ->
    Tutorial.search().then (error, result) ->
      response.json tutorials: (tutorial.parse() for tutorial in result)
