var
  paths,
  gulp,
  plugins,
  getTask;

gulp = require('gulp');
plugins = require('gulp-load-plugins')();

// Define the paths.
paths = {
  'injectIndex': './index.html',
  'vendor': {
    'app': './bower_components/foundation-apps/scss/**/*.scss'
  },
  'bower': {
    'base': 'bower_components',
    'css': {
      'min': [
        'bootstrap/dist/css/bootstrap.min.css',
        'bootstrap/dist/css/bootstrap-theme.min.css',
        'angular/angular-csp.css'
      ],
      'src': [
        'bootstrap/dist/css/bootstrap-theme.css',
        'bootstrap/dist/css/bootstrap-theme.css.map',
        'bootstrap/dist/css/bootstrap.css',
        'bootstrap/dist/css/bootstrap.css.map'
      ]
    },
    'js': {
      'min': [
        'angular/angular.min.js',
        'angular-bootstrap/ui-bootstrap.min.js',
        'angular-bootstrap/ui-bootstrap-tpls.min.js'
      ],
      'src': [
        'angular/angular.js',
        'angular/angular.min.js.map',
        'angular-bootstrap/ui-bootstrap.js',
        'angular-bootstrap/ui-bootstrap-tpls.js'
      ]
    },
    'extra': [
      'bootstrap/dist/fonts/glyphicons-halflings-regular.eot',
      'bootstrap/dist/fonts/glyphicons-halflings-regular.svg',
      'bootstrap/dist/fonts/glyphicons-halflings-regular.ttf',
      'bootstrap/dist/fonts/glyphicons-halflings-regular.woff',
      'bootstrap/dist/fonts/glyphicons-halflings-regular.woff2'

    ]
  },
  'src': {
    'app': [
      './src/**/*.coffee'
    ],
    'index': 'src/assets/index.html'
  },
  'dest': {
    'dist': 'dist/',
    'app': 'static/sudoku/',
    'static': 'static/',
    'index': '/'
  }
};

// Define the task.
getTask = function(task) {
  return require('./gulp-tasks/' + task)(gulp, plugins, paths);
}

// Define tasks.
gulp.task('angular-app', getTask('angular-app'));
gulp.task('clean', getTask('clean'));
gulp.task('index', getTask('index'));

// Watch for changes.
gulp.task('watch', function() {
  gulp.watch(paths.src.app, ['angular-app']);
  gulp.watch(paths.src.index, ['index']);
});

// Default.
gulp.task('default', ['clean', 'angular-app', 'index', 'watch']);
