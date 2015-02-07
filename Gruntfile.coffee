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
      test:
        command: "#{jasmine} --captureExceptions --coffee spec/"
        options:
          stdout: true
          stderr: true
          failOnError: true

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-coffeelint')

  grunt.registerTask('lint', ['coffeelint'])
  grunt.registerTask('default', ['coffee', 'lint'])
  grunt.registerTask('test', ['coffee', 'lint', 'shell:test'])
