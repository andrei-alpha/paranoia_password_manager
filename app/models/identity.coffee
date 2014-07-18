module.exports = class Identity extends Backbone.Model
  decryptAttribute: (attribute, masterPassword, progressCallback,
                     doneCallback) ->
    triplesec.decrypt
      data: triplesec.Buffer(@get(attribute), 'hex')
      key: triplesec.Buffer(masterPassword)
      progress_hook: progressCallback
    , (err, buff) -> doneCallback(err, buff)

  encryptAttribute: (attribute, masterPassword, value, doneCallback) ->
    triplesec.encrypt
      data: triplesec.Buffer(value)
      key: triplesec.Buffer(masterPassword)
      progress_hook: (obj) ->
    , (err, buff) =>
      if !err
        @set(attribute, buff.toString('hex'))
        doneCallback()
