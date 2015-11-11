# Karma configuration
# Generated on Tue Nov 10 2015 10:31:29 GMT+0900 (JST)

module.exports = (config) ->
  config.set
    frameworks: ['jasmine']
    files: [
      'src/main/js/components/**/*.js'
      'src/test/js/**/*Spec.coffee'
    ]
    preprocessors:
      '**/*.coffee': 'coffee' 

    plugins: [
      'karma-phantomjs-launcher'
      'karma-jasmine'
      'karma-coffee-preprocessor'
    ]

    browsers: ['PhantomJS']