"use strict"

# -- Extend common attributes --------------------------------------------------
Atoms.Organism.Section.available.push "Atom.Editor"
# ------------------------------------------------------------------------------

class Atoms.Organism.Chapter extends Atoms.Organism.Article

  @url: "assets/scaffold/article.course.json"

  constructor: ->
    super
    do @render
    if localStorage.getItem("atoms.studio") is "EN"
      @header.nav.language.refresh text: "Español"
      @header.title.refresh value: __.C.chapter_0
      @section.doc.md.refresh value: __.C.md_0
    else
      @header.nav.language.refresh text: "English"
    unless __.Entity.Tutorial.all().length isnt 0
      __.proxy("GET", "tutorials", null).then (error, result) ->
        __.Entity.Tutorial.create tutorial for tutorial in result.tutorials


  # -- Children Bubble Events --------------------------------------------------
  onEnglish: (event, dispatcher) ->
    if localStorage.getItem("atoms.studio") is "EN"
      dispatcher.refresh text: "English"
      localStorage.setItem "atoms.studio", "ES"
    else
      dispatcher.refresh text: "Español"
      localStorage.setItem "atoms.studio", "EN"
    window.location.reload()

  onEditorChange: (editor) ->
    @section.canvas.app.value editor.value()

  chapter: (index) ->
    chapter = __.Entity.Tutorial.findBy "chapter", index
    @header.title.refresh value: chapter.title
    @section.editor.value chapter.yaml
    @section.canvas.app.value chapter.code
    if localStorage.getItem("atoms.studio") is "EN"
      @header.title.refresh value: __.C["chapter_#{chapter.chapter}"]
    readme = "#{chapter.readme.split(".html")[0]}-#{localStorage.getItem("atoms.studio")}.html"
    $.get readme, (text) =>
      document.getElementById("doc").innerHTML = text

  onEditorError: ->
    console.log "onEditorError"

new Atoms.Organism.Chapter()
