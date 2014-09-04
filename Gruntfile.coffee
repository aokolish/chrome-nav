module.exports = (grunt) ->

  grunt.initConfig
    src_file: "content-script"
    copy:
      build:
        cwd: 'src'
        src: ['**']
        dest: 'build'
        expand: true

    coffee:
      options:
        bare: true
      compile:
        files:
          'build/<%= src_file %>.js': './<%= src_file %>.coffee'

    uglify:
      options:
        banner: "/*! <%= src_file %> <%= grunt.template.today(\"yyyy-mm-dd\") %> */\n"
      build:
        src: "<%= src_file %>.js"
        dest: "build/<%= src_file %>.min.js"


  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-copy"

  grunt.registerTask "default", ["uglify"]
