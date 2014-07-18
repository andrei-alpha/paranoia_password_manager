module.exports = class LoginView extends Backbone.View

  template: require 'views/templates/login'

  events:
    'click #login-submit' : 'loginSubmit'

  render: ->
    @$el.html(@template())
    this

  setMasterPassword: () ->
    window.masterPassword = @masterPassword
    Backbone.history.navigate('#', {trigger: true})

  onVerify: (err, buff) =>
    if err
      @$('#login-error').show()
    else
      @setMasterPassword()

  loginSubmit: ->
    @masterPassword = @$('#login-master-password').val()
    model = @collection.models[0]
    if model
      model.decryptAttribute('username', @masterPassword, null, @onVerify)
    else
      @setMasterPassword()