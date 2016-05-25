gulp = require('gulp')
require('gulp-lazyload')
  concat:     'gulp-concat'
  preprocess: 'gulp-preprocess'
  rename:     'gulp-rename'
  del:        'del'
  plumber:    'gulp-plumber'
  replace:    'gulp-replace'

gulp.task 'default', ['build', 'watch'], ->

gulp.task 'build', ->
  gulp.src('__manifest__.sass')
  .pipe plumber()
  .pipe replace(/^\s*@import ((?:[a-z-]+\/)*)([a-z-]+)(?:\.sass)?$/gmi, '// @include $1_$2.sass')
  .pipe preprocess()
  .pipe concat('_eskimo.sass')
  .pipe gulp.dest('.')

gulp.task 'watch', ->
  gulp.watch ['mixins/**/*', 'functions/**/*', 'helpers/**/*', 'reset/**/*'], ['build']