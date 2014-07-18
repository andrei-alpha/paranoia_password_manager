module.exports = class IdentityView extends Backbone.View

  template: require 'views/templates/identity'
  progress_template: require 'views/templates/progress_bar'

  events:
    'click #identity-delete': 'delete'
    'click #identity-decrypt': 'decrypt'

  render: ->
    @$el.html(@template(@model.attributes))
    this

  updateDecryptProgress: (percentage, $el) ->
    data =
      percentage: percentage
      progress_bar_class: 'progress-bar-striped'
    $el.html(@progress_template(data))

  decrypt: ->
    @$('#identity-decrypt').prop('disabled', true)

    $password_el = @$('#identity-password')
    $username_el = @$('#identity-username')

    @model.decryptAttribute("password", window.masterPassword,
      (percentage) => @updateDecryptProgress(percentage, $password_el),
      (err, value) => $password_el.text(value)
      )
    @model.decryptAttribute("username", window.masterPassword,
      (percentage) => @updateDecryptProgress(percentage, $username_el),
      (err, value) => $username_el.text(value)
      )

  delete: (event) ->
    event.preventDefault()

    @model.destroy
      success: -> console.log('identity deleted')
      error: -> alert('failed to delete identity')
    Backbone.history.navigate('#', {trigger: true})
