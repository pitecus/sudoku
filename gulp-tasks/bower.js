module.exports = function (gulp, plugins, paths) {
  return function () {
    // Copy files.
    gulp.src(paths.bower.files, {
      'base': paths.bower.base,
      'cwd': paths.bower.base
    })
    .pipe(gulp.dest(paths.dest.dist + paths.dest.bower));
  };
};
