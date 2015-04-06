var
  coffee,
  lint,
  threshold,
  util;

coffee = require('gulp-coffee');
lint = require('gulp-coffeelint');
threshold = require('gulp-coffeelint-threshold');
util = require('gulp-util');

module.exports = function (gulp, plugins, paths) {
  return function () {
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
    .pipe(gulp.dest(paths.dest.app));
  };
};
