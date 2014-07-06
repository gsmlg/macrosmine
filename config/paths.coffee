{join} = require 'path'
config = exports.config = __dirname

root = exports.root = join config, '..'

public_folder = exports.public = join root, 'public'

app = exports.app = join root, 'app'

models = exports.models = join app, 'models'

views = exports.views = join app, 'views'

controllers = exports.controllers = join app, 'controllers'

assets = exports.assets = join app, 'assets'


