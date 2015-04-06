var
  bower,
  inject,
  util;

bower = require('main-bower-files');
inject = require('gulp-inject');
util = require('gulp-util');

module.exports = function (gulp, plugins, paths) {
  return function () {
    var
      i,
      prependBower,
      prependStatic,
      bower,
      files;

    // Prepend the bower base.
    prependBower = function (curr) {
      return paths.bower.base + '/' + curr;
    };

    // Prepend the static path.
    prependStatic = function (curr) {
      return paths.dest.static + curr;
    };

    // List of files to copy.
    files = [];
    Array.prototype.push.apply(files, paths.bower.css.min);
    Array.prototype.push.apply(files, paths.bower.css.src);
    Array.prototype.push.apply(files, paths.bower.js.min);
    Array.prototype.push.apply(files, paths.bower.js.src);
    Array.prototype.push.apply(files, paths.bower.extra);

    // Copy all files.
    gulp.src(files.map(prependBower), {
      'base': paths.bower.base
    })
    .pipe(gulp.dest(paths.dest.dist + paths.dest.static));

    // Minified files.
    bower = [];
    Array.prototype.push.apply(bower, paths.bower.css.min);
    Array.prototype.push.apply(bower, paths.bower.js.min);

    // Inject the JS/CSS inside the file.
    gulp.src(paths.src.index, {
      'base': 'src/assets'
    })
    .pipe(inject(gulp.src(bower.map(prependStatic), {
      'read': false,
      'cwd': paths.dest.dist
    })))
    // .pipe(inject(gulp.src(['./dist/static/bootstrap/dist/css/*.css'], {'read': false})))
    .pipe(gulp.dest(paths.dest.dist));
  };
};
