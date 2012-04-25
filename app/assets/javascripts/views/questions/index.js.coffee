class Formr.Views.QuestionsIndex extends Backbone.View

  template: JST['questions/index']

  events:
    'submit #new_question': 'createQuestion'
    'click #new_text_field': 'createTextField'
    'click #new_text_area': 'createTextArea'
    'click #new_checkbox': 'createTextArea'
    'click #new_radiobutton': 'createTextArea'
    'click #new_select_field': 'createTextArea'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendQuestion, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendQuestion)
    this

  createQuestion: (question) ->
    question.preventDefault()
    attributes = title: $('#new_question_title').val()
    @collection.create attributes,
      wait: true
      success: -> $('#new_question')[0].reset()
      error: @handleError
  
  createTextField: (e) ->
    console.log(e.target.attributes[1])

  createTextArea: ->
    alert(1)

	
  appendQuestion: (question) ->
    view = new Formr.Views.Question(model: question)
    @$('#form_container').prepend(view.render().el)

  handleError: (question, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
