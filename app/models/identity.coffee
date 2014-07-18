module.exports = class Identity extends Backbone.Model
  @getPercentage: (obj)->
    if obj.what == 'pbkdf2 (pass 1)'
      return 5 * obj.i / obj.total
    else if obj.what == 'scrypt'
      return 5 + 90 * obj.i / obj.total
    else
      return 99

  decryptAttribute: (attribute, masterPassword, progressCallback,
                     doneCallback) ->
    triplesec.decrypt
      data: triplesec.Buffer(@get(attribute), 'hex')
      key: triplesec.Buffer(masterPassword)
      progress_hook: (obj)->
        progressCallback(Identity.getPercentage(obj)) if progressCallback
    , (err, buff) ->
      doneCallback(err, buff) if doneCallback

  encryptAttribute: (attribute, masterPassword, value,
                     progressCallback, doneCallback) ->
    triplesec.encrypt
      data: triplesec.Buffer(value)
      key: triplesec.Buffer(masterPassword)
      progress_hook: (obj)->
        progressCallback(Identity.getPercentage(obj)) if progressCallback
    , (err, buff) =>
      if !err
        @set(attribute, buff.toString('hex'))
        doneCallback() if doneCallback
