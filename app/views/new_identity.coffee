Identity = require 'models/identity'

module.exports = class NewIdentityView extends Backbone.View

  PASSWORD_LENGTH = 12

  template: require 'views/templates/new_identity'
  progress_template: require 'views/templates/progress_bar'

  events:
    'click #new_identity_save' : 'save'
    'keyup #new_identity_password' : 'password_change'
    'change #new_identity_password' : 'password_change'
    'click #new_identity_generate_pass': 'generatePassword'

  initialize: ->
    @password_strenght_view

  render: ->
    @$el.html(@template())
    @password_change()
    this

  validate: ->
    hasError = false

    name = @$('#new_identity_name').val().trim()
    $formGroup = @$('#new_identity_name').closest('.form-group')
    if name.length == 0
      $formGroup.addClass('has-error')
      hasError = true
    else
      $formGroup.removeClass('has-error')

    username = @$('#new_identity_username').val()
    $formGroup = @$('#new_identity_username').closest('.form-group')
    if username.length == 0
      $formGroup.addClass('has-error')
      hasError = true
    else
      $formGroup.removeClass('has-error')

    password = @$('#new_identity_password').val()
    $formGroup = @$('#new_identity_password').closest('.form-group')
    if password.length == 0
      $formGroup.addClass('has-error')
      hasError = true
    else
      $formGroup.removeClass('has-error')

    return not hasError

  save: (event)->
    event.preventDefault()

    if not @validate()
      return

    name = @$('#new_identity_name').val().trim()
    username = @$('#new_identity_username').val()
    password = @$('#new_identity_password').val()

    @$('#new_identity_save').prop('disabled', true)

    @updateProgress(0)
    @collection.addIdentity(name, username, password, window.masterPassword
      (percentage) => @updateProgress(percentage),
      () -> Backbone.history.navigate('#', {trigger: true})
    )

  updateProgress: (percentage)->
    data =
      percentage: percentage
      progress_bar_class: 'progress-bar-default'
      message: "Encrypting..."
    @$('#save_progress_bar').html(@progress_template(data))

  generatePassword: ->
    if not window.crypto or window.crypto.getRandomValues
      allowedLetters = 'abcdefghijklmnopqrstuvwxyz'
    password = ''
    while password.length < PASSWORD_LENGTH
      randomBuff = new Uint8Array(200)
      window.crypto.getRandomValues(randomBuff)
      for b in randomBuff
        c = String.fromCharCode(b)
        if c in allowedLetters
          password += c
          if password.length == PASSWORD_LENGTH
            break
    @$('#new_identity_password').val(password)
    @password_change()

  password_change: ->
    password = @$('#new_identity_password').val().trim()
    result = zxcvbn(password)
    score = result.score

    if password.length > 0 and score == 0
      score = 1

    data_dict =
      0:
        progress_bar_class: 'progress-bar-default'
        message: ''
      1:
        percentage: 25
        progress_bar_class: 'progress-bar-danger'
        message: 'Very Weak'
      2:
        percentage: 50
        progress_bar_class: 'progress-bar-warning'
        message: 'Weak'
      3:
        percentage: 75
        progress_bar_class: 'progress-bar-info'
        message: 'Adequate'
      4:
        percentage: 100
        progress_bar_class: 'progress-bar-success'
        message: 'Strong'

    data = data_dict[score]
    data.percentage = 25 * score
    @$('#password_strength_bar').html(@progress_template(data))
    @$('#password_crack_time').text(result.crack_time_display)
