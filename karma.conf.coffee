# Karma configuration
# Generated on Mon Apr 13 2015 14:43:40 GMT-0400 (EDT)

module.exports = (config) ->
  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    'basePath': ''

    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    'frameworks': [
      'mocha'
      'sinon-chai'
    ]

    # list of files / patterns to load in the browser
    'files': [
      'bower_components/angular/angular.js'
      'bower_components/angular-bootstrap/ui-bootstrap.js'
      'bower_components/angular-mocks/angular-mocks.js'
      #'src/app/**/*.coffee'
      'src/app/modules.coffee'
      'src/app/services/board.coffee'
      'test/**/*Spec.coffee'
    ]

    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    'reporters': [
      'progress'
      'coverage'
    ]

    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    'preprocessors':
      'src/app/modules.coffee': [
        'coverage'
      ]
      'src/app/services/board.coffee': [
        'coverage'
      ]
      'test/**/*.coffee': [
        'coffee'
      ]

    'coverageReporter':
      'dir': 'coverage'
      'reporters': [
          'type': 'html'
          'subdir': 'report-html/'
        ,
          'type': 'text-summary'
          'subdir': '.'
      ]

    # web server port
    'port': 9876

    # enable / disable colors in the output (reporters and logs)
    'colors': true

    # level of logging
    # possible values:
    # - config.LOG_DISABLE
    # - config.LOG_ERROR
    # - config.LOG_WARN
    # - config.LOG_INFO
    # - config.LOG_DEBUG
    'logLevel': config.LOG_DEBUG

    # enable / disable watching file and executing tests whenever any file changes
    'autoWatch': true

    # start these browsers
    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    'browsers': [
      'PhantomJS'
    ]

    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    'singleRun': false
