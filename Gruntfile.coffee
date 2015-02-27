module.exports = (grunt) ->
  require("load-grunt-tasks") grunt
  require('time-grunt') grunt

  collapse = require('bundle-collapser/plugin')

  grunt.initConfig
    config:
      sourceDir: "src"
      destinationDir: "build"

    browserify:
      options:
        transform: ['coffeeify']
        plugin: [collapse]
        browserifyOptions:
          extensions: [".coffee", ".js"]
      jsx:
        files: [
          src: ["<%= config.sourceDir %>/transformer.coffee"]
          dest: "<%= config.destinationDir %>/jsx.js"
        ]

    uglify:
      jsx:
        options:
          mangle: true
          compress: true
        files:
          "<%= config.destinationDir %>/jsx.min.js": ["<%= config.destinationDir %>/jsx.js"]

  grunt.registerTask 'default', [
    'browserify'
    'uglify'
  ]

  return
