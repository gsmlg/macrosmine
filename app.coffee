express = require('express')
module.exports = app = express()

config = require './config'

config.view_engine(app)

app.use express.static(__dirname + '/public')
app.use config.route

app.use '/assets', config.assets

app.get '/end', (req, res)->
  res.send 200, 'Good Night!'
  res.end()
