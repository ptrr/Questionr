class Formr.Routers.Options extends Backbone.Router
  routes:
    '': 'index'
    'options/:id': 'show'

  initialize: ->
    @collection = new Formr.Collections.Options()
    @collection.fetch()

  index: ->
    view = new Formr.Views.OptionsIndex(collection: @collection)
    $('.option_container').html(view.render().el)
  
  show: (id) ->
    alert "Question #{id}"


