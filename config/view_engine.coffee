module.exports = (app)->
  {join} = require 'path'
  paths = require './paths'
  views_path = paths.views
  engine = require 'express4-handlebars'
  extname = engine.get 'extname'

  app.set 'views', views_path

  app.engine extname, engine.__express
  app.set 'view engine', extname

  engine.set 'layout_dir', join(views_path, 'layout')
  engine.set 'partials_dir', join(views_path, 'partials')
  engine.set 'useLayout', true
  engine.set 'layout', 'layout'
