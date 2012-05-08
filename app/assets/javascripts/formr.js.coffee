window.Formr =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new Formr.Routers.Questions()
    #new Formr.Routers.Options()    
    
    Backbone.history.start()

$(document).ready ->
  Formr.init()
