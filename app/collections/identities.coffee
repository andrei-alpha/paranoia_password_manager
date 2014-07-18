Identity = require 'models/identity'

module.exports = class IdentityCollection extends Backbone.Collection
  model: Identity

  dropboxDatastore: new Backbone.DropboxDatastore('IdentityCollection')

  initialize: ->
    @dropboxDatastore.syncCollection(@)

  storeIdentityIfCompleted: (identity, savedCallback) ->
    if identity.get('username') and identity.get('password')
      @add(identity)
      identity.save {},
        success: -> console.log('saved new identity')
        error: -> alert('failed to save new identity')
      savedCallback()

  addIdentity: (name, username, password, progressCallback, doneCallback) ->
    identity = new Identity()
    identity.set('name', name)
    identity.encryptAttribute('password', @window.masterPassword, password,
      () => @storeIdentityIfCompleted(identity, doneCallback))
    identity.encryptAttribute('username', @window.masterPassword, username,
      () => @storeIdentityIfCompleted(identity, doneCallback))
