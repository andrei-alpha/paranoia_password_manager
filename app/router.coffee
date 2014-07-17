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
    @showView new ListIdentitiesView
      collection: @identities

  new: ->
    console.log 'new'
    @showView new NewIdentityView
      collection: @identities

  settings: ->
    console.log 'settings'

  identity: (id)->
    console.log 'identity', id
    identity = @identities.get id
    @showView new IdentityView
      model: identity

  showView: (view)->
    if @view
      @view.remove()
      @view.unbind()
    @view = view
    @view.render()
    el: $('.root-view').append(@view.el)

module.exports = ParanoiaRouter
