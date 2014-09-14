## -- Dependencies -------------------------------------------------------------

translate   = require 'sailor-translate'
errorify    = require 'sailor-errorify'

## -- Exports ------------------------------------------------------------------

module.exports =

  endpoint: (req, res)->
    req.assert('method', translate.get "MailChimp.Method.NotFound").notEmpty()
    req.assert('action', translate.get "MailChimp.Action.NotFound").notEmpty()
    return res.badRequest(errorify.serialize(req)) if req.validationErrors()

    params = do req.params.all

    method = params.method
    action = params.action

    delete params.action
    delete params.method

    MailChimpService.api method, action, params, (err, response) ->
      return res.badRequest(err) if err
      res.ok(response)
