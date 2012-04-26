class Formr.Views.Question extends Backbone.View
  template: JST['questions/question']
  tagName: 'div'
  className: "control-group"
  
  events:
    "dblclick .title": "edit"
    "blur .question_input" : "close"
    'submit .title_form': 'handleDefault'

  initialize: ->
    @model.on('change', @render, this)
    #@model.on('highlight', @highlightWinner, this)

  render: ->
    $(@el).html(@template(question: @model))
    $(@el).children('span').html(@model.get('title'))
    this

  edit: (e)->
    $(e.currentTarget).addClass("editing")


  close: (e)->
    console.log(e.currentTarget.value)
    @model.save title: e.currentTarget.value,
      wait: true
      success: (model, response) ->
        model.fetch()
        $(e.currentTarget).parents('.title').removeClass('editing')
      error: @handleError
         
  handleDefault: (e) ->
    e.preventDefault()
    @model.save title: e.currentTarget.lastElementChild.value,
      wait: true
      success: (model, response) ->
        model.fetch()
        $(e.currentTarget.lastElementChild).removeClass("editing")
      error: @handleError
    

  handleError: (question, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
  
  
