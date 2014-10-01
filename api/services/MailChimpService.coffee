## -- Dependencies -------------------------------------------------------------

sailor             = require 'sailorjs'
translate          = sailor.translate
errorify           = sailor.errorify

MailChimp          = require 'mailchimp'
mailchimpConfig    = sails.config.mailchimp

MailChimp_API      = MailChimp.MailChimpAPI
MailChimpExportAPI = MailChimp.MailChimpExportAPI
MailChimpWebhook   = MailChimp.MailChimpWebhook

MailChimp =
  API     : new MailChimp_API(mailchimpConfig.key, { version : mailchimpConfig.api.version })
  EXPORT  : new MailChimpExportAPI(mailchimpConfig.key, { version : mailchimpConfig.export.version, secure: mailchimpConfig.export.secure })
  WEBHOOK : new MailChimpWebhook()

## -- Exports ------------------------------------------------------------------

module.exports =

  api: (method, action, query, cb) ->
    MailChimp.API.call method, action, query, (err, data) ->
      unless err then cb(err, data) else cb(errorify.serialize err, data)
