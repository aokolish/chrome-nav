module.exports = (grunt) ->

  grunt.initConfig
    src_file: "content-script"
    copy:
      build:
        cwd: 'src'
        src: ['**']
        dest: 'build'
        expand: true

    clean:
      build:
        src: 'build'
      scripts:
        src: 'build/content-script.coffee'

    coffee:
      options:
        bare: true
      build:
        expand: true,
        cwd: 'build',
        src: [ './content-script.coffee' ],
        dest: 'build',
        ext: '.js'

  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"

  grunt.registerTask "build", ['clean:build', 'copy', 'coffee', 'clean:scripts']
  grunt.registerTask "default", ['build']
