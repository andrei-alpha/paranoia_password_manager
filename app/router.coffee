Identity = require 'models/identity'

IdentityCollection = require 'collections/identities'

ListIdentitiesView = require 'views/list_identities'
IdentityView = require 'views/identity'
NewIdentityView = require 'views/new_identity'

ParanoiaRouter = Backbone.Router.extend
  routes:
    '': 'listIdentities'
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

  listIdentities: ->
    window.identities = @identities
    console.log("listIdentities")
    view = new ListIdentitiesView
      el: $('.root-view')
      collection: @identities
    view.render()

  new: ->
    console.log 'new'
    view = new NewIdentityView
      el: $('.root-view')
      collection: @identities
    view.render()

  settings: ->
    console.log 'settings'

  identity: (id)->
    console.log 'identity', id
    identity = @identities.get id
    view = new IdentityView
      el: $('.root-view')
      model: identity
    view.render()

module.exports = ParanoiaRouter
