class Formr.Views.OptionsIndex extends Backbone.View
  template: JST['options/index']
  


  initialize: ->
    @collection.on('add', @appendOption, this)
    @collection.on('reset', @render, this)

  render: ->
    console.log("Rendering options")
    $(@el).html(@template())
    @collection.each(@appendOption)
    this


      #view = new Formr.Views.Option(model: option)
    #@$('#question_options_'+question_id).append(view.render().el)

  appendOption: (option) ->
    console.log(option)
    view = new Formr.Views.Option(model: option)
    $('#question_options_'+option.get('question_id')).append(view.render().el)
    

	
  handleError: (question, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages


