"use strict"

class Atoms.Organism.AsideChapters extends Atoms.Organism.Aside

  @url: "assets/scaffold/aside.chapters.json"

  constructor: ->
    super
    do @render

  onChapter: (event, atom) ->
    __.Article.Chapter.chapter atom.attributes.text

new Atoms.Organism.AsideChapters()
