module.exports =
  home: (req, res)->
    res.render 'site/home', {
      AppName: "MacrosMine"
      topMenus: [
        {name: "pages", link: "/#pages"},
        {name: "macros", link: "/#macros"}
      ]
    }
