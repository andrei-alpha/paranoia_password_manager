module.exports = class ListIdentitiesView extends Backbone.View

  template: require 'views/templates/identity'

  render: ->
    @$el.html(@template(@model.attributes))
    this
