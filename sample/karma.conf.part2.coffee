# Karma configuration
# Generated on Tue Nov 10 2015 10:31:29 GMT+0900 (JST)

module.exports = (config) ->
  config.set
    frameworks: ['jasmine']
    files: [
      'src/test/js/**/*Spec.coffee'
    ]
    preprocessors:
      'src/test/js/**/*Spec.coffee': ['webpack']

    plugins: [
      'karma-phantomjs-launcher'
      'karma-jasmine'
      'karma-webpack'
    ]

    browsers: ['PhantomJS']

    webpack: addCoffeeLoader require('./webpack.config')

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