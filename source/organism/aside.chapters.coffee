"use strict"

class Atoms.Organism.AsideChapters extends Atoms.Organism.Aside

  @url: "assets/scaffold/aside.chapters.json"

  constructor: ->
    super
    do @render
    __.proxy("GET", "tutorials").then (error, result) ->
      console.log "error", error
      console.log "result", result

  onChapter: (event, atom) ->
    console.log "CHAPTER.#{atom.attributes.text}"

new Atoms.Organism.AsideChapters()
