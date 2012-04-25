class Formr.Routers.Questions extends Backbone.Router
	routes:
    '': 'index'
    'questions/:id': 'show'

  initialize: ->
    @collection = new Formr.Collections.Questions()
    @collection.fetch()

  index: ->
    view = new Formr.Views.QuestionsIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "Question #{id}"
