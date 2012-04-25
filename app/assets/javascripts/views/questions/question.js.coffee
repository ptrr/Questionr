class Formr.Views.Question extends Backbone.View
  template: JST['questions/question']
  tagName: 'div'
  className: "control-group"

  initialize: ->
    @model.on('change', @render, this)
    @model.on('highlight', @highlightWinner, this)

  render: ->
    $(@el).html(@template(question: @model))
    this
