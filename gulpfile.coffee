gulp = require 'gulp'
rename = require 'gulp-rename'
gutil = require 'gulp-util'
coveralls = require 'coveralls'
gulpCoveralls = require 'gulp-coveralls'

webpack = require 'webpack-stream'
webpackConf = require './webpack.config.coffee'

KarmaServer = require('karma').Server

path = require 'path'
util = require 'util'
merge2 = require 'merge2'
through = require 'through2'

gulp.task 'build', ->
  gulp.src 'src/main/js/index.js'
  .pipe webpack webpackConf
  .pipe rename 'bundle.js'
  .pipe gulp.dest 'dist/'

gulp.task 'test', (cb) ->
  server = new KarmaServer {
    configFile: path.join __dirname, 'karma.conf.coffee'
    singleRun: true
  }, cb
  do server.start

gulp.task 'coveralls', ->
  gulp.src 'coverage/**/lcov.info'
    .pipe do gulpCoveralls

gulp.task 'coveralls:merge', ->
  error = (cb, err) ->
    @emit 'error', new gutil.PluginError 'xxxx', err
    do cb

  mapper = (lcov, fileName) ->
    return through.obj (file, enc, cb) ->
      if file.isNull()
        @push file
        return do cb

      done = (str) =>
        newFile = new gutil.File
          cwd: file.cwd,
          base: file.base,
          path: file.base + fileName

        newFile.contents = new Buffer str
        @push newFile
        return do cb

      output = file.contents.toString enc
      if lcov
        coveralls.convertLcovToCoveralls output, {}, (err, json) ->
          if err
            error.call @, cb, err
          done JSON.stringify json
      else
        done output

  merger = () ->
    json =
      source_files: []

    transformer = (file, enc, cb) ->
      data = JSON.parse(file.contents)
      data.source_files.forEach (source) ->
        json.source_files.push source

      @push file
      do cb

    flush = (cb) ->
      coveralls.getBaseOptions (err, options) =>
        if err
          error.call @, cb, err
        options.filepath = '.'
        util._extend(json, options)
        coveralls.sendToCoveralls json, (err, response, body) =>
          if err
            error.call @, cb, err
          else if response.statusCode != 200
            error.call @, cb, JSON.stringify(body)
          else
            console.log body
            do cb

    return through.obj transformer, flush

  inputs = [{
    # JavaScript
    file: 'coverage/lcov.info'
    lcov: true
  }, {
    # Java
    file: 'coverage/java.json'
  }]

  return merge2(inputs.map (input) ->
      gulp.src(input.file)
        .pipe mapper input.lcov, input.file + '.mapped'
    )
    .pipe do merger
