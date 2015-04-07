module.exports = function (gulp, plugins, paths) {
  return function () {
    // Copy files.
    gulp.src(paths.src.templates.files, {
      'cwd': paths.src.templates.cwd
    })
    .pipe(gulp.dest(paths.dest.dist + paths.dest.templates));
  };
};
