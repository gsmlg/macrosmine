Router = require('express').Router
_ = require 'underscore'

router = new Router

site = require '../app/controllers/siteController'

router.get '/', site.home

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
