class Formr.Views.Option extends Backbone.View
  template: JST['options/option']
  tagName: "li"
  className: ""

  events:
    "click .option_label": "edit"
    "blur .option_label_form" : "close"
    'submit .option_label_form': 'handleDefault'
    "click .remove_option" : "removeOption"

  initialize: ->
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template(option: @model))
    this
	
  edit: (e)->
    $(e.currentTarget).focus()
    $("#option_label_"+@model.id).addClass("editing")
    $("#option_form_"+@model.id).addClass("editing")


  removeOption: (e) ->
    @model.destroy
      wait: true
      success: ->
        $(e.currentTarget).parent().remove()
      error: @handleError


  handleDefault: (e) ->
    e.preventDefault()
    @model.save option_label: e.currentTarget.lastElementChild.value,
      wait: true
      success: (model, response) ->
        model.fetch()
        $("#option_form_"+model.id).removeClass('editing')
        $("#option_label_"+model.id).removeClass('editing')
      error: @handleError

  close: (e)->
    @model.save option_label: e.currentTarget.lastElementChild.value,
      wait: true
      success: (model, response) ->
        model.fetch()
        $("#option_form_"+model.id).removeClass('editing')
        $("#option_label_"+model.id).removeClass('editing')
      error: @handleError


  handleError: (question, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
  
