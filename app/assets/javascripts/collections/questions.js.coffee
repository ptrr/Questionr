class Formr.Collections.Questions extends Backbone.Collection

  form_id = $('#container').data('form-id')
  url: '/api/forms/'+form_id+'/questions'

  comparator: (item) ->
    return item.get('order')
