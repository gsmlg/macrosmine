Mincer = require 'mincer'
{join} = require 'path'
root = join __dirname, '..'
types = ['javascripts', 'stylesheets', 'images']

assets = new Mincer.Environment()

assets.appendPath join(root, 'lib')

for name in types
  assets.appendPath join(root, 'app', 'assets', name)


module.exports = Mincer.createServer assets
