module.exports = app = require('express')()

config = require './config'

app.engine 'hbs', config.view_engine
app.set 'view engine', 'hbs'
app.set 'views', __dirname + '/app/views'

app.use config.route

app.get '/', (req, res)->
  res.send 200, 'Good Night!'
  res.end()
