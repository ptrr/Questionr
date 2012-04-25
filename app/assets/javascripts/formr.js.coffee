window.Formr =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new Formr.Routers.Questions()
    Backbone.history.start()

$(document).ready ->
  Formr.init()
