module.exports = class LoginView extends Backbone.View

  template: require 'views/templates/login'

  events:
    'click #login-submit' : 'loginSubmit'
    'keypress #login-master-password': 'passwordOnKeypress'

  render: ->
    @$el.html(@template())
    this

  setMasterPassword: () ->
    window.masterPassword = @masterPassword
    Backbone.history.navigate('#', {trigger: true})

  onVerify: (err, buff) =>
    if err
      $formGroup = @$('#login-master-password').closest('.form-group')
      $formGroup.addClass('has-error')
      $formGroup.find('.control-label').text('Wrong password')
    else
      @setMasterPassword()

  loginSubmit: ->
    @masterPassword = @$('#login-master-password').val()
    model = @collection.models[0]
    if model
      model.decryptAttribute('username', @masterPassword, null, @onVerify)
    else
      @setMasterPassword()

  passwordOnKeypress: (e) ->
    code = e.keyCode or e.which
    if code == 13
      @loginSubmit()
