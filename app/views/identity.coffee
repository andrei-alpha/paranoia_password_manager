module.exports = class ListIdentitiesView extends Backbone.View

  template: require 'views/templates/identity'

  events:
    'click #identity_delete' : 'delete'

  render: ->
    @$el.html(@template(@model.attributes))
    this

  delete: (event)->
    event.preventDefault()

    @model.destroy
      success: -> console.log('identity deleted')
      error: -> alert('failed to delete identity')
    Backbone.history.navigate('#', {trigger: true})
