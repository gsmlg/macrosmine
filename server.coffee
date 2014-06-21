app = require './app'
server = require('http').createServer app

server.listen 18080, ->
  console.log "Server is running on port 18080"
