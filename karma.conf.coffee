# Karma configuration
# Generated on Tue Nov 10 2015 10:31:29 GMT+0900 (JST)

module.exports = (config) ->
  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: ''


    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine']


    # list of files / patterns to load in the browser
    files: [
      'src/test/js/entry.coffee'
    ]


    # list of files to exclude
    exclude: [
    ]


    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors:
      'src/test/js/entry.coffee': ['webpack']

    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress', 'coverage']


    # web server port
    port: 9876


    # enable / disable colors in the output (reporters and logs)
    colors: true


    # level of logging
    # possible values:
    # - config.LOG_DISABLE
    # - config.LOG_ERROR
    # - config.LOG_WARN
    # - config.LOG_INFO
    # - config.LOG_DEBUG
    logLevel: config.LOG_INFO


    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: false


    # start these browsers
    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['PhantomJS']


    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: false

    # Concurrency level
    # how many browser should be started simultanous
    concurrency: Infinity

    plugins: [
      'karma-phantomjs-launcher'
      'karma-jasmine'
      'karma-webpack'
      'karma-coverage'
    ]

    coverageReporter:
      type: 'lcov'
      dir: 'coverage'
      subdir: '.'

    webpack: addCoffeeLoader addIstanbulPreLoader require('./webpack.config')

extend = (require 'util')._extend

addIstanbulPreLoader = (input) ->
  output = extend {}, input
  output.module ||= {}
  output.module.preLoaders ||= []
  output.module.preLoaders.every((l) -> l.loader isnt 'istanbul-instrumenter') and output.module.preLoaders.push
    loader: 'istanbul-instrumenter'
    test: /\.js$/
    include: require('path').resolve('src/main/js/components')

  return output

addCoffeeLoader = (input) ->
  output = extend {}, input
  output.module ||= {}
  output.module.loaders ||= []
  output.module.loaders.every((l) -> l.loader isnt 'coffee-loader') and output.module.loaders.push
    loader: 'coffee-loader'
    test: /\.coffee$/

  output.resolve ||= {}
  output.resolve.extensions ||= []
  output.resolve.extensions.indexOf('.coffee') < 0 and output.resolve.extensions.push '.coffee'

  return output
