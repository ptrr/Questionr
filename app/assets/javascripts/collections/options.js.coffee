class Formr.Collections.Options extends Backbone.Collection
  url: '/api/questions/1/options'

  create_url: (question) ->
    return '/api/questions/'+question.get('id')+'/options' 
