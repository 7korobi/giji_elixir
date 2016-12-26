module.exports = (grunt)->
  pkg = grunt.file.readJSON 'package.json'
  config =
    pkg: pkg

    watch:
      files: ['{web,test}/static/**/*.coffee']
      tasks: ['make', 'spec']

    coffee:
      src:
        options:
          bare: false
        files: {}

    mochaTest:
      test:
        options:
          reporter: "min"
          require: "intelli-espower-loader"
        src: ["test/static-power/**/*.js"]

  config.coffee.src.files["test/static-power/mocha.js"] = ["test/**/*.coffee"]
  grunt.initConfig config

  for task, ver of pkg.devDependencies when task[..5] == "grunt-"
    grunt.loadNpmTasks task

  grunt.task.registerTask "default", ["make", "spec", "watch"]
  grunt.task.registerTask "make", ["coffee"]
  grunt.task.registerTask "spec", ["mochaTest"]
