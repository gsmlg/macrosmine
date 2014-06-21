Router = require('express').Router

router = new Router

router.get '/', (req, res)->
  res.render 'layout', {title: 'Home', name: 'JoJo'}

router.get '/:name', (req, res)->
  name = req.param('name')
  res.render 'layout', {title: "Welcome #{name? and name or ''}", name: name}

router.get '/js/:file', (req, res)->
  name = req.param('file')
  res.set 'Content-Type', 'application/javascript'
  res.send "console.log('#{name} has loaded and execute!')"
  res.end()

module.exports = router
