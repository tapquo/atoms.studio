"use strict"

# -- Extend common attributes --------------------------------------------------
Atoms.Organism.Section.available.push "Atom.Code"
Atoms.Organism.Section.available.push "Atom.Textarea"
# ------------------------------------------------------------------------------

class Atoms.Organism.Chapter extends Atoms.Organism.Article

  @url: "assets/scaffold/article.course.json"

  constructor: ->
    super
    do @render

new Atoms.Organism.Chapter()
