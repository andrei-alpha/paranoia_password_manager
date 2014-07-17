module.exports = class ListIdentitiesView extends Backbone.View

  template: require 'views/templates/list_identities'

  initialize: ->
    @collection.on('add reset remove', @update, @)

  update: ->
    @render()

  render: ->
    @$el.html(@template({identities: @collection.models}))
    this
