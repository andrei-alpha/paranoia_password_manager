ParanoiaRouter = Backbone.Router.extend
  routes:
    '': 'home'

  home: ->
    console.log("home")

module.exports = ParanoiaRouter
