"use strict"

# -- Extend common attributes --------------------------------------------------
Atoms.Organism.Section.available.push "Atom.Editor"
# ------------------------------------------------------------------------------

class Atoms.Organism.Chapter extends Atoms.Organism.Article

  @url: "assets/scaffold/article.course.json"

  constructor: ->
    super
    do @render
    unless __.Entity.Tutorial.all().length isnt 0
      __.proxy("GET", "tutorials", null).then (error, result) ->
        __.Entity.Tutorial.create tutorial for tutorial in result.tutorials


  # -- Children Bubble Events --------------------------------------------------
  onEditorChange: (editor) ->
    @section.canvas.app.value editor.value()

  chapter: (index) ->
    chapter = __.Entity.Tutorial.findBy "chapter", index
    @header.title.refresh value: chapter.title
    @section.editor.value chapter.yaml
    @section.canvas.app.value chapter.code
    $.get chapter.readme, (text) =>
      document.getElementById("doc").innerHTML = text

  onEditorError: ->
    console.log "onEditorError"

new Atoms.Organism.Chapter()
