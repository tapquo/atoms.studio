"use strict"
Test = require("zenrequest").Test

module.exports = ->
  tasks = []
  tasks.push _newChapter tutorial for tutorial in ZENrequest.tutorials
  tasks

# -- Tasks ---------------------------------------------------------------------
_newChapter = (tutorial) -> ->
  Test "POST", "tutorial", tutorial, null, null, 200

