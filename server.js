var http = require('http');
var app = require('express')();
var port = 18080;

app.get('/', function(req, res){
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.write('<h1>Node.js</h1>');
    res.end('<p>Hello World</p>');
});

http.createServer(app).listen(port);
