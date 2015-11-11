# Karma configuration
# Generated on Tue Nov 10 2015 10:31:29 GMT+0900 (JST)

module.exports = (config) ->
  config.set
    frameworks: ['jasmine']
    files: [
      'src/test/js/entry.coffee'
    ]
    preprocessors:
      'src/test/js/entry.coffee': ['webpack']

    plugins: [
      'karma-phantomjs-launcher'
      'karma-jasmine'
      'karma-webpack'
      'karma-coverage'
    ]
    reporters: ['progress', 'coverage']
    browsers: ['PhantomJS']
    webpack: addCoffeeLoader addIstanbulPreLoader require('./webpack.config')

    coverageReporter:
      type: 'lcov'
      dir: 'coverage'
      subdir: '.'

addIstanbulPreLoader = (input) ->
  path = require 'path'
  extend = (require 'util')._extend
  output = extend {}, input
  output.module ||= {}
  output.module.preLoaders ||= []
  output.module.preLoaders.every((l) -> l.loader isnt 'istanbul-instrumenter') and output.module.preLoaders.push
    loader: 'istanbul-instrumenter'
    test: /\.js$/
    include: path.resolve('src/main/js/components') # テスト対象のみ、解析対象とする

  return output

addCoffeeLoader = (input) ->
  extend = require('util')._extend
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