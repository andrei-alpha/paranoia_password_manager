module.exports = class IdentityView extends Backbone.View

  template: require 'views/templates/identity'

  events:
    'click #identity-delete': 'delete'
    'click #identity-decrypt': 'decrypt'

  render: ->
    @$el.html(@template(@model.attributes))
    this

  updateDecryptProgress: (percentage, $el) ->
    console.log percentage

  decrypt: ->
    @$('#identity-decrypt').prop('disabled', true)

    @model.decryptAttribute("password", window.masterPassword,
      (percentage) => @updateDecryptProgress(percentage, "password"),
      (err, value) => @$('#identity-password').text(value)
      )
    @model.decryptAttribute("username", window.masterPassword,
      (percentage) => @updateDecryptProgress(percentage, "username"),
      (err, value) => @$('#identity-username').text(value)
      )

  delete: (event) ->
    event.preventDefault()

    @model.destroy
      success: -> console.log('identity deleted')
      error: -> alert('failed to delete identity')
    Backbone.history.navigate('#', {trigger: true})
