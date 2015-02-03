"use strict"

# -- Extend common attributes --------------------------------------------------
Atoms.Organism.Section.available.push "Atom.Editor"
# ------------------------------------------------------------------------------

class Atoms.Organism.Chapter extends Atoms.Organism.Article

  @url: "assets/scaffold/article.course.json"

  constructor: ->
    super
    do @render

  # -- Children Bubble Events --------------------------------------------------
  onEditorChange: (editor) ->
    @section.canvas.app.value editor.value()

  onEditorError: ->
    console.log "onEditorError"

new Atoms.Organism.Chapter()
