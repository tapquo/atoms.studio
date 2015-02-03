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

        - Organism.Section:
            id: section
            style: active
            children:
              - Molecule.Div:
                  id: doc
                  children:
                    - Atom.Text:
                        value: Welcome to Learn Atoms.js.

              - Atom.Button:
                  style: fluid
                  text: sss
    """

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
