module.exports = app = require('express')()

config = require './config'

app.engine 'html', config.view_engine
app.set 'view engine', 'html'
app.set 'views', __dirname + '/app/views'

app.use config.route

app.get '/', (req, res)->
  res.send 200, 'Good Night!'
  res.end()
