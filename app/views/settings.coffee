module.exports = class SettingsView extends Backbone.View

  template: require 'views/templates/settings'

  render: ->
    @$el.html(@template())
    this
