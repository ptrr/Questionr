class Formr.Views.QuestionsIndex extends Backbone.View
  template: JST['questions/index']

  events:
    'click .add_question': 'createQuestion'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendQuestion, this)

  render: (e) ->
    $(@el).html(@template())
    @collection.each(@appendQuestion)
    this

  createQuestion: (e) ->
    attributes = title: e.target.attributes[1].nodeValue, question_type: e.target.attributes[1].nodeValue
    @collection.create attributes,
      wait: true
      success: (model, response) ->
        console.log(response)
      error: @handleError

  appendQuestion: (question) ->
    view = new Formr.Views.Question(model: question, collection: @question_options)
    @$('#form_container').prepend(view.render().el).children().animate({
    backgroundColor: '#fff'}, 2000)

  handleError: (question, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
