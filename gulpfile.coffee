gulp = require('gulp')
require('gulp-lazyload')
  concat:     'gulp-concat'
  preprocess: 'gulp-preprocess'
  rename:     'gulp-rename'
  del:        'del'
  plumber:    'gulp-plumber'
  replace:    'gulp-replace'
  sass:       'gulp-sass'
  jade:       'gulp-jade'
  csso:       'gulp-csso'
  _:          'underscore'
  gzip:       'gulp-gzip'
  faker:      'faker'

gulp.task 'default', ['build', 'watch'], ->

gulp.task 'build', ['css', 'html'], ->

gulp.task 'css', ->
  gulp.src('test/test.sass')
    .pipe plumber()
    .pipe sass()
    .pipe concat('test.css')
    .pipe gulp.dest('test')
    .pipe csso()
    .pipe rename('test.min.css')
    .pipe gulp.dest('test')
    .pipe gzip(append: true, gzipOptions: { level: 9 })
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
