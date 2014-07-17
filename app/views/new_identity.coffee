Identity = require 'models/identity'

module.exports = class NewIdentitiesView extends Backbone.View

  template: require 'views/templates/new_identity'

  events:
    'click #new_identity_save' : 'save'

  initialize: ->
    @saved = false

  render: ->
    @$el.html(@template())
    this

  save: (event)->
    event.preventDefault()

    if @saved
      return
    @saved = true

    name = @$('#new_identity_name').val().trim()
    username = @$('#new_identity_username').val().trim()
    password = @$('#new_identity_password').val().trim()

    @identity = new Identity()
    @identity.set('name', name)
    @identity.set('username', username)
    @identity.set('password', password)

    @collection.add(@identity)
    @identity.save {},
      success: -> console.log('saved new identity')
      error: -> alert('failed to save new identity')

    Backbone.history.navigate('#', {trigger: true})
