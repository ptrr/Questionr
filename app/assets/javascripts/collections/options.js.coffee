class Formr.Collections.Options extends Backbone.Collection
  url: '/api/questions/1/options'
  comparator: (item) ->
      return item.get('order')

  create_url: (question) ->
    return '/api/questions/'+question.get('id')+'/options'

  create_option_url: (id) ->
    return '/api/questions/'+id+'/options'
    
