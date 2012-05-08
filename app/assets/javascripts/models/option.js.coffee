class Formr.Models.Option extends Backbone.Model
  url: '/api/questions/1/options/'
  
  create_url: (question_id) ->
    return '/api/questions/'+question_id+'/options/'

  defaults:
    option_label: "Nieuw"
    option_value: "Nieuw"
    question_id: 1
