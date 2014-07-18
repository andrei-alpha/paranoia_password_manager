module.exports = class ListIdentitiesView extends Backbone.View

  template: require 'views/templates/identity'

  events:
    'click #identity-delete': 'delete'
    'click #identity-decrypt': 'decrypt'

  render: ->
    @$el.html(@template(@model.attributes))
    this

  updateDecryptProgress: (obj, $el) ->

  decrypt: ->
    @$('#identity-decrypt').prop('disabled', true)

    @model.decryptAttribute("password", "password",
      (obj) => @updateDecryptProgress(obj, "password"),
      (err, value) => @$('#identity-password').text(value)
      )
    @model.decryptAttribute("username", "password",
      (obj) => @updateDecryptProgress(obj, "username"),
      (err, value) => @$('#identity-username').text(value)
      )

  delete: (event) ->
    event.preventDefault()

    @model.destroy
      success: -> console.log('identity deleted')
      error: -> alert('failed to delete identity')
    Backbone.history.navigate('#', {trigger: true})
