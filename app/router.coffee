Identity = require 'models/identity'

IdentityCollection = require 'collections/identities'

ListIdentitiesView = require 'views/list_identities'
IdentityView = require 'views/identity'
NewIdentityView = require 'views/new_identity'
SettingsView = require 'views/settings'
LoginView = require 'views/login'

ParanoiaRouter = Backbone.Router.extend
  routes:
    '': 'identities'
    'login': 'login'
    'new': 'new'
    'settings': 'settings'
    'identity/:id': 'identity'

  initialize: ->
    @initDropboxDatastores()

    @identities = new IdentityCollection()
    @identities.fetch()

  initDropboxDatastores: ->
    client = new Dropbox.Client({key: 'dzifnkasbikzon7'})
    # Try to finish OAuth authorization.
    client.authenticate({interactive: false})
    # Redirect to Dropbox to authenticate if client isn't authenticated
    if !client.isAuthenticated()
      client.authenticate()
    # Set client for Backbone.DropboxDatastore to work with Dropbox
    Backbone.DropboxDatastore.client = client

  identities: ->
    window.identities = @identities
    @showView new ListIdentitiesView
      collection: @identities

  login: ->
    @showView new LoginView(
      collection: @identities
    ), false

  new: ->
    @showView new NewIdentityView
      collection: @identities

  settings: ->
    @showView new SettingsView
      collection: @identities

  identity: (id)->
    identity = @identities.get id
    @showView new IdentityView
      model: identity

  showView: (view, passwordRequired=true) ->
    console.log("show view", window.masterPassword)
    if passwordRequired and not window.masterPassword
      console.log('wtf', passwordRequired)
      Backbone.history.navigate('#login', {trigger: true})
      return
    console.log(view)
    if @view
      @view.remove()
      @view.unbind()
    @view = view
    @view.render()
    el: $('.root-view').append(@view.el)

module.exports = ParanoiaRouter
