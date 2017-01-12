gulp    = require 'gulp'
concat  = require 'gulp-concat'
plumber = require 'gulp-plumber'
sass    = require 'gulp-sass'
jade    = require 'gulp-jade'
_       = require 'underscore'
faker   = require 'faker'

gulp.task 'default', ['build', 'watch'], ->

gulp.task 'build', ['css', 'html'], ->

gulp.task 'css', ->
  gulp.src('test/test.sass')
    .pipe plumber()
    .pipe sass()
    .pipe concat('test.css')
    .pipe gulp.dest('test')

gulp.task 'html', ->
  gulp.src('test/test.jade')
    .pipe plumber()
    .pipe jade(locals: {_, faker})
    .pipe concat('test.html')
    .pipe gulp.dest('test')

gulp.task 'watch', ->
  gulp.watch ['test/test.sass', 'test/test.jade',
              'mixins/**/*', 'helpers/**/*', 'reset/**/*', 'math/**/*', '*.sass', '*.scss'], ['build']
