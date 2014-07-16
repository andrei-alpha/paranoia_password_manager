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
    @identities = new IdentityCollection()
    stub_identity1 = new Identity()
    stub_identity1.set 'name', 'Facebook'
    stub_identity1.set 'username', 'test'
    stub_identity1.set 'password', 'pass123'
    @identities.add stub_identity1
    stub_identity2 = new Identity()
    stub_identity2.set 'name', 'Google Apps'
    stub_identity2.set 'username', 'test'
    stub_identity2.set 'password', 'pass789'
    @identities.add stub_identity2

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
