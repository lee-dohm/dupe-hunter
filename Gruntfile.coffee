module.exports = (grunt) ->
  jasmine = './node_modules/jasmine-focused/bin/jasmine-focused'

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      glob_to_multiple:
        expand: true
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'lib'
        ext: '.js'

    coffeelint:
      options: grunt.file.readJSON('coffeelint.json')
      src: ['src/*.coffee']
      test: ['spec/*.coffee']

    shell:
      spec:
        command: "#{jasmine} --captureExceptions --coffee spec/"
        options:
          stdout: true
          stderr: true
          failOnError: true

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-coffeelint')

  grunt.registerTask 'clean', -> require('rimraf').sync('lib')
  grunt.registerTask('lint', ['coffeelint:src', 'coffeelint:test'])
  grunt.registerTask('default', ['lint', 'spec'])
  grunt.registerTask('spec', ['shell:spec'])
  grunt.registerTask('test', ['spec'])
