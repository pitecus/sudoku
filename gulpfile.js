var
  paths,
  gulp,
  plugins,
  getTask,
  livereload;

gulp = require('gulp');
plugins = require('gulp-load-plugins')();
livereload = require('gulp-livereload');

// Define the paths.
paths = {
  'bower': {
    'base': 'bower_components',
    'files': [
      // Stylesheets - angular.
      'angular/angular-csp.css',
      // Stylesheets - bootstrap.
      'bootstrap/dist/css/bootstrap.css',
      'bootstrap/dist/css/bootstrap.css.map',
      'bootstrap/dist/css/bootstrap.min.css',
      // Stylesheets - bootstrap angular.
      'bootstrap/dist/css/bootstrap-theme.css',
      'bootstrap/dist/css/bootstrap-theme.css.map',
      'bootstrap/dist/css/bootstrap-theme.min.css',
      // Javascript - angular.
      'angular/angular.js',
      'angular/angular.min.js',
      'angular/angular.min.js.map',
      // Javascript - bootstrap angular.
      'angular-bootstrap/ui-bootstrap.js',
      'angular-bootstrap/ui-bootstrap.min.js',
      'angular-bootstrap/ui-bootstrap-tpls.js',
      'angular-bootstrap/ui-bootstrap-tpls.min.js',
      // Extras - Bootstrap.
      'bootstrap/dist/fonts/glyphicons-halflings-regular.eot',
      'bootstrap/dist/fonts/glyphicons-halflings-regular.svg',
      'bootstrap/dist/fonts/glyphicons-halflings-regular.ttf',
      'bootstrap/dist/fonts/glyphicons-halflings-regular.woff',
      'bootstrap/dist/fonts/glyphicons-halflings-regular.woff2'
    ],
  },
  'src': {
    'app': [
      './src/app/**/*.coffee'
    ],
    'index': 'src/assets/index.html',
    'templates': {
      'cwd': 'src/templates',
      'files': [
        '**/*.html'
      ]
    },
    'less': 'src/styles/**/*.less'
  },
  'dest': {
    'dist': 'dist/',
    'app': 'web/app/',
    'bower': 'web/static/',
    'index': 'web/',
    'less': 'web/',
    'templates': 'web/templates'
  }
};

// Define the task.
getTask = function(task) {
  return require('./gulp-tasks/' + task)(gulp, plugins, paths);
}

// Define tasks.
gulp.task('angular', getTask('angular'));
gulp.task('bower', getTask('bower'));
gulp.task('clean', getTask('clean'));
gulp.task('index', ['bower'], getTask('index'));
gulp.task('styles', getTask('styles'));
gulp.task('templates', getTask('templates'));

// Watch for changes.
gulp.task('watch', function() {
  livereload.listen();
  gulp.watch(paths.src.app, ['angular']);
  gulp.watch(paths.src.index, ['index']);
  gulp.watch(paths.src.less, ['styles']);
  gulp.watch(paths.src.templates.cwd + paths.src.templates.files, ['templates']);
});

// Default.
gulp.task('build', ['angular', 'bower', 'index', 'styles', 'templates']);

// Default.
gulp.task('default', ['build', 'watch']);
