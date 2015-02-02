"use strict"

class Atoms.Organism.AsideChapters extends Atoms.Organism.Aside

  @url: "assets/scaffold/aside.chapters.json"

  constructor: ->
    super
    do @render

  onChapter: (event, atom) ->
    console.log "CHAPTER.#{atom.attributes.text}"

new Atoms.Organism.AsideChapters()
