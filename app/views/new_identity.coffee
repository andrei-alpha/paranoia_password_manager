Identity = require 'models/identity'

module.exports = class NewIdentityView extends Backbone.View

  template: require 'views/templates/new_identity'
  password_strength_template: require 'views/templates/password_strength'

  events:
    'click #new_identity_save' : 'save'
    'keyup #new_identity_password' : 'password_change'
    'change #new_identity_password' : 'password_change'

  initialize: ->
    @password_strenght_view

  render: ->
    @$el.html(@template())
    @password_change()
    this

  save: (event)->
    event.preventDefault()

    name = @$('#new_identity_name').val().trim()
    username = @$('#new_identity_username').val()
    password = @$('#new_identity_password').val()

    @collection.addIdentity(name, username, password,
      (obj) ->,
      () -> Backbone.history.navigate('#', {trigger: true})
    )

  password_change: ->
    password = @$('#new_identity_password').val().trim()
    result = zxcvbn(password)
    score = result.score

    # Override the score for weak passwords unless it is empty.
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
    @$('#password_strength_bar').html(@password_strength_template(data))

