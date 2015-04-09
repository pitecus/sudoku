var
  util,
  minifyHTML,
  livereload;

util = require('gulp-util');
minifyHTML = require('gulp-minify-html');
livereload = require('gulp-livereload');

module.exports = function (gulp, plugins, paths) {
  return function () {
    // Copy index.
    gulp.src(paths.src.index)
    .pipe(minifyHTML())
    .pipe(gulp.dest(paths.dest.dist + paths.dest.index))
    .pipe(livereload());;
  };
};
