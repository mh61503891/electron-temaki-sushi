gulp = require('gulp')
$ = require('gulp-load-plugins')()

gulp.task 'default', ['test']

gulp.task 'test', ['lint']

gulp.task 'lint', ['lint-json', 'lint-coffee', 'lint-html']

gulp.task 'lint-json', ->
  gulp.src('package.json')
    .pipe($.jsonlint())

gulp.task 'lint-coffee', ->
  gulp.src(['gulpfile.coffee', 'src/**/*.coffee', 'templates/**/*.coffee'])
    .pipe($.coffeelint())
    .pipe($.coffeelint.reporter('coffeelint-stylish'))

gulp.task 'lint-html', ->
  gulp.src('template/**/*.html')
    .pipe($.html5Lint())
