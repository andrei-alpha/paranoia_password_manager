Identity = require 'models/identity'

module.exports = class IdentityCollection extends Backbone.Collection
  model: Identity

  dropboxDatastore: new Backbone.DropboxDatastore('IdentityCollection')

  initialize: ->
    @dropboxDatastore.syncCollection(@)