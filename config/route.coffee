Router = require('express').Router
_ = require 'underscore'

router = new Router

site = require '../app/controllers/siteController'

router.get '/',(n...)->
  site = require '../app/controllers/siteController'
  site.home n...

router.get '/:name', (req, res)->
  name = req.param('name')
  res.render 'layout', {title: "Welcome #{name? and name or ''}", name: name}

router.get '/js/:file', (req, res)->
  name = req.param('file')
  res.set 'Content-Type', 'application/javascript'
  res.send "console.log('#{name} has loaded and execute!')"
  res.end()

funcs = _.functions router

router.options '/', (req, res)->
  methods = funcs
  res.set 'Allow-Mehthods', methods.join(',')
  res.send methods.join('\n')
  res.end()

module.exports = router
