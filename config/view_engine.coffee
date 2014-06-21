{join, extname, dirname} = require 'path'
fs = require 'fs'
handlebars = require 'handlebars'

view_engine = (path, options, fn)->
  options.filename = path
  readPartials path, options, (err)->
    return fn err if err
    if cache options
      render '', options, fn
    else
      read path, options, (err, str)->
        return fn(err) if err
        render str, options, fn

render = view_engine.render = (str, options, fn)->
  engine = handlebars
  try
    engine.registerPartial name, partial for name, partial of options.partials
    engine.registerHelper name, helper for name, helper of options.helpers
    tpl = (cache options) or (cache options, engine.compile(str, options))
    fn null, tpl(options)
  catch error
    fn error


readCache = {}

cacheStore = {}

cache = (options, compiled)->
  if compiled and options.filename and options.cache
    delete readCache[options.filename]
    cacheStore[options.filename] = compiled
    return compiled

  if options.filename and options.cache and options.cacheStore[options.filename]?
    return cacheStore[options.filename]

  compiled

read = (path, options, fn)->
  str = readCache[path]
  cached = options.cache and str and typeof str is 'string'

  return fn null, str if cached

  fs.readFile path, 'utf8', (err, str)->
    return fn(err) if err
    str = str.substr 1 if str[0] is "\uFEFF"
    readCache[path] = str if options.cache
    fn null, str

readPartials = (path, options, fn)->
  return fn() if !options.partials
  partials = options.partials
  keys = Object.keys partials

  next = (index)->
    return fn(null) if index is keys.length
    key = keys[index]
    file = join dirname(path), partials[key] + extname(path)
    read file, options, (err, str)->
      return fn(err) if err
      options.partials[key] = str
      next ++index

  next 0

module.exports = view_engine
