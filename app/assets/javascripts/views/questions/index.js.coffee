class Formr.Views.QuestionsIndex extends Backbone.View
  template: JST['questions/index']

  events:
    'click .add_question': 'createQuestion'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendQuestion, this)

  render: (e) ->
    console.log(e)
    console.log("Rendering questions")
    $(@el).html(@template())
    @collection.each(@appendQuestion)
    this

  createQuestion: (e) ->
    attributes = title: e.target.attributes[1].nodeValue, question_type: e.target.attributes[1].nodeValue
    console.log(attributes)
    @collection.create attributes,
      wait: true
      success: (model, response) ->
        console.log(response)
      error: @handleError


	
  appendQuestion: (question) ->
    view = new Formr.Views.Question(model: question, collection: @question_options)
    @$('#form_container').prepend(view.render().el).children().animate({
    backgroundColor: '#efefef'}, 300)

  handleError: (question, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
