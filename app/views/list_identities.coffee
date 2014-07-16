module.exports = class ListIdentitiesView extends Backbone.View

  template: require 'views/templates/list_identities'

  render: ->
    @$el.html(@template({identities: @collection.models}))
    this
