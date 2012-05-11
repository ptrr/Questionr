class Formr.Collections.Options extends Backbone.Collection
  form_id = $('#container').data('form-id')
  url: '/api/forms/1/questions/1/options'

  comparator: (item) ->
    return item.get('order')

  create_url: (question) ->
    return '/api/forms/'+form_id+'/questions/'+question.get('id')+'/options'

  create_option_url: (id) ->
    return '/api/forms/'+form_id+'/questions/'+id+'/options'

