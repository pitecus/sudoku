var
  util,
  less,
  mini,
  livereload;

util = require('gulp-util');
less = require('gulp-less');
mini = require('gulp-minify-css');
livereload = require('gulp-livereload');

module.exports = function (gulp, plugins, paths) {
  return function () {
    // Copy index.
    gulp.src(paths.src.less)
    .pipe(less())
    .pipe(mini())
    .pipe(gulp.dest(paths.dest.dist + paths.dest.less))
    .pipe(livereload());
  };
};
