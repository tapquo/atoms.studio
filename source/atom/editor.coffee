"use strict"

class Atoms.Atom.Editor extends Atoms.Class.Atom

  @template = "<code></code>"
  @base     = "Editor"
  @events   : ["change", "error"]

  constructor: ->
    super
    example = """
      id: course
      style: active
      children:
        - Organism.Header:
            id: header
            children:
              - Atom.Heading:
                  id: title
                  style: left
                  value: 1. Title Chapter
              - Molecule.Navigation:
                  style: right
                  children:
                    - Atom.Link:
                        text: 1
                    - Atom.Link:
                        text: 2
                    - Atom.Button:
                        text: Reset

        - Organism.Section:
            id: section
            children:
              - Molecule.Div:
                  id: doc
                  children:
                    - Atom.Text:
                        value: Welcome to Learn Ractive.js. This is a set of interactive tutorials which you can take at your own pace. Each tutorial consists of a number of steps – you're currently on step 1 of the 'Hello world!' tutorial.
              - Atom.Editor:
                  id: editor
              - Molecule.Div:
                  id: canvas
                  children:
                    - Atom.App:
                        id: app"""

    Atoms.$ =>
      @instance = CodeMirror @el[0],
        value       : example
        mode        : "text/x-yaml"
        lineNumbers : true
        indentUnit  : 2
        tabSize     : 2
        # theme       : "monokai"
      @instance.on "change", =>
        try
          jsyaml.load @instance.getValue()
          @bubble "change", @
        catch e
          @bubble "error", @

  value: (value) ->
    if value
      @instance.setValue value
    else
      jsyaml.load @instance.getValue()
