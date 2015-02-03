"use strict"

class Atoms.Atom.App extends Atoms.Class.Atom

  @template: """
    <div data-atoms="app"></div>
  """

  @base: "App"

  constructor: ->
    super
    @view = new Atoms.Organism.Article container: @el[0]
    @view.render()

  value: (attributes) =>
    console.log attributes
    try
      @view.refresh attributes
    catch e
      console.log "?"

