module.exports =

  home: (req, res)->
    res.render 'site/home', {
      name: 'My Home'
      layout: 'layout'
      partials:
        'header': '../partials/header'
        'footer': '../partials/footer'
    }
