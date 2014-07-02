{join} = require 'path'
gulp = require 'gulp'
require('./lib/task_loader')(gulp)
gulp.loadTasks join(__dirname, 'tasks')
