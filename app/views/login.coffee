module.exports = class LoginView extends Backbone.View

  template: require 'views/templates/login'
  progress_template: require 'views/templates/progress_bar'

  events:
    'click #login-submit' : 'loginSubmit'
    'keypress #login-master-password': 'passwordOnKeypress'

  render: ->
    @$el.html(@template())
    @$('#login_progress_bar').hide()
    this

  setMasterPassword: () ->
    window.masterPassword = @masterPassword
    Backbone.history.navigate('#', {trigger: true})

  onVerify: (err, buff) =>
    @$('#login_progress_bar').hide()
    if err
      $formGroup = @$('#login-master-password').closest('.form-group')
      $formGroup.addClass('has-error')
      $formGroup.find('.control-label').text('Wrong password')
      @$('#login-submit').prop('disabled', false)
    else
      @setMasterPassword()

  updateProgress: (percentage) =>
    @$('#login_progress_bar').show()
    data =
      percentage: percentage
      progress_bar_class: 'progress-bar-default'
      message: "Authenticating..."
    @$('#login_progress_bar').html(@progress_template(data))

  loginSubmit: ->
    if @$('#login-submit').prop('disabled') == true
      return
    @masterPassword = @$('#login-master-password').val()
    model = @collection.models[0]
    @$('#login-submit').prop('disabled', true)
    if model
      model.decryptAttribute('username', @masterPassword,
                             @updateProgress, @onVerify)
    else
      @setMasterPassword()

  passwordOnKeypress: (e) ->
    code = e.keyCode or e.which
    if code == 13
      @loginSubmit()
