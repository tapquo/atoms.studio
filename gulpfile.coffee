'use strict'

gulp    = require 'gulp'
coffee  = require 'gulp-coffee'
concat  = require 'gulp-concat'
connect = require 'gulp-connect'
header  = require 'gulp-header'
uglify  = require 'gulp-uglify'
gutil   = require 'gulp-util'
stylus  = require 'gulp-stylus'
yml     = require 'gulp-yml'
pkg     = require './package.json'

path =
  assets: "./www/assets"

source =
  coffee: [
    "source/*.coffee"
    "source/entity/*.coffee"
    "source/atom/*.coffee"
    "source/molecule/*.coffee"
    "source/organism/*.coffee"]
  stylus: [
    "source/style/*.styl"]

atoms =
  js: [
    "bower_components/atoms/atoms.js"
    "bower_components/atoms/atoms.app.js"]
  css: [
    "bower_components/atoms/atoms.app.css"]

banner = [
  "/**"
  " * <%= pkg.name %> - <%= pkg.description %>"
  " * @version v<%= pkg.version %>"
  " * @link    <%= pkg.homepage %>"
  " * @author  <%= pkg.author.name %> (<%= pkg.author.site %>)"
  " * @license <%= pkg.license %>"
  " */"
  ""
].join("\n")

gulp.task "webserver", ->
  connect.server
    port      : 8080
    livereload: true

gulp.task "atoms", ->
  gulp.src atoms.js
    .pipe concat "#{pkg.name}.js"
    .pipe gulp.dest "#{path.assets}/js"
  gulp.src atoms.css
    .pipe concat "#{pkg.name}.css"
    .pipe gulp.dest "#{path.assets}/css"

gulp.task "coffee", ->
  gulp.src source.coffee
    .pipe concat "atoms.studio.coffee"
    .pipe(coffee().on('error', gutil.log))
    .pipe uglify mangle: false
    .pipe header banner, pkg: pkg
    .pipe gulp.dest "#{path.assets}/js"
    .pipe connect.reload()

gulp.task "stylus", ->
  gulp.src source.stylus
    .pipe concat "atoms.studio.styl"
    .pipe stylus
      compress: true
      errors: true
    .pipe header banner, pkg: pkg
    .pipe gulp.dest "#{path.assets}/css"
    .pipe connect.reload()

gulp.task "init", ["atoms", "coffee", "stylus"]

gulp.task "default", ->
  gulp.run ["webserver"]
  gulp.watch source.coffee, ["coffee"]
  gulp.watch source.stylus, ["stylus"]
