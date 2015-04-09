var
  coffee,
  lint,
  threshold,
  util,
  concat,
  uglify,
  sourcemaps,
  livereload;

coffee = require('gulp-coffee');
lint = require('gulp-coffeelint');
threshold = require('gulp-coffeelint-threshold');
util = require('gulp-util');
concat = require('gulp-concat');
uglify = require('gulp-uglify');
sourcemaps = require('gulp-sourcemaps');
livereload = require('gulp-livereload');

module.exports = function (gulp, plugins, paths) {
  return function () {
    // Copy coffee files.
    gulp.src(paths.src.app)
    .pipe(lint({
      'optFile': 'coffeelint.json'
    }))
    .pipe(lint.reporter())
    .pipe(threshold(10, 0, function(warns, errors) {
      util.beep();
      throw new Error('Coffeling failure: ' + warns + ' warning and ' + errors + ' errors.');
    }))
    .pipe(coffee({
      'bare': true
    }).on('error', util.log))
    .pipe(concat('sudoku.js'))
    .pipe(sourcemaps.init())
      .pipe(uglify())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest(paths.dest.dist + paths.dest.app))
    .pipe(livereload());;
  };
};
