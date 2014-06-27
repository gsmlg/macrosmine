isBrowser = window? and navigator? and window.document?
commentRegExp = /(\/\*([\s\S]*?)\*\/|([^:]|^)\/\/(.*)$)/mg
cjsRequireRegExp = /[^.]\s*require\s*\(\s*["']([^'"\s]+)["']\s*\)/g
jsSuffixRegExp = /\.js$/
currDirRegExp = /^\.\//


class Loader
  @config = {}

  @_modules = []

  class @Module
    constructor: (path, relative)->
      @resolve_path path, relative if path?
      @

    _getpath: (path)->
      path = path.substring 0, path.lastIndexOf('/')
      path + '/'

    resolve_path: (path, relative)->
      if /^\./.test path and relative?
        rel_path = @_getpath relative

  constructor: ->
    scripts = @scripts()
    for script in scripts when script.getAttribute('data-main')?
      path = script.getAttribute 'data-main'
      require = new Require(name)
      require.load path

  scripts: ->
    document.getElementsByTagName 'script'



lookupDependence = (func)->
  deps = []
  if func.length
    func
      .toString()
      .replace commentRegExp, ''
      .replace cjsRequireRegExp, (match, dep)->
        deps.push dep
  deps


window.define = (callback)->
  dependencies = lookupDependence callback
  Loader.currentDefine ||= []
  Loader.currentDefine.push {dependencies: dependencies, definition: callback}
  @



class Require
  constructor: (name)->
    @name = name
    @loaded = @loaded.bind @

  load: (path)->
    @path = path
    script = document.createElement 'script'
    script.type = 'text/javascript'
    script.src = path
    loaded = @loaded

    if script.addEventListener?
      script.addEventListener 'load', loaded, false
    else if script.readyState?
      script.onreadystatechange = loaded
    else
      throw new Error "Can't listen on load!"

    script.onerror = (e)->
      console.log "load script %s error", path

    document.body.appendChild script

  loaded: ->
    definitions = Loader.currentDefine
    Loader.currentDefine = null
    console.log "script #{@path} loaded"
    console.log JSON.stringify(definitions)
