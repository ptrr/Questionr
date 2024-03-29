class Formr.Views.Question extends Backbone.View
  template: JST['questions/question']
  tagName: 'div'
  className: "control-group"

  events:
    "click .title": "edit"
    "blur .question_input" : "close"
    'submit .title_form': 'handleDefault'
    "click .add_option" : "addOption"
    "click .remove_question" : "removeQuestion"
    "click .question_required" : "requireQuestion"

  initialize: ->
    @model.on('change', @render, this)
    @questionOptions = ''
    #@model.on('highlight', @highlightWinner, this)

  render: ->
    console.log(@model)
    $(@el).html(@template(question: @model))
    $(@el).children('span.title').html(@model.get('title'))
    @questionOptions = new Formr.Collections.Options()
    @questionOptions.url = @questionOptions.create_url(@model)
    @questionOptions.fetch()
    option_view = new Formr.Views.OptionsIndex(collection: @questionOptions, model: @model)
    $("div#question_options_"+@model.get('id')).html(option_view.render().el)
    this

  edit: (e)->
    $(e.currentTarget).addClass("editing")
    $('input[name="question_title_'+@model.id+'"]').focus()

  requireQuestion: (e) ->
    if $(e.currentTarget).attr('checked') == 'checked'
      @model.save required: 1,
        wait: true
        success: (response, model) ->
          $(e.currentTarget).attr('checked', 'checked')
        error: @handleError

  removeQuestion: (e) ->
    @model.destroy
      wait: true
      success: ->
        $(e.currentTarget).parents('.control-group').remove()
      error: @handleError


  close: (e)->
    @model.save title: e.currentTarget.value,
      wait: true
      success: (model, response) ->
        model.fetch()
        $(e.currentTarget).parents('.title').removeClass('editing')
      error: @handleError

  addOption:(e)->
    e.preventDefault()
    #option = new Formr.Models.Option()
    question_id = @model.id
    question_type =  @model.get('question_type')
    #option.url = option.create_url(question_id)
    order = @questionOptions.length
    console.log (order)
    @questionOptions.create question_id: question_id, option_label: 'Optie', option_type: question_type, order: order,
      #url: '/api/questions/'+question_id+'/options'
      wait: true
      success: (model, response) ->
        model.fetch()
      error: @handleError


  handleDefault: (e) ->
    console.log(e)
    @model.save title: e.currentTarget.lastElementChild.value,
      wait: true
      success: (model, response) ->
        model.fetch()
        console.log(e.currentTarget.lastElementChild)
        $(e.currentTarget.lastElementChild).parents('.title').removeClass("editing")
      error: @handleError
    e.preventDefault()



  handleError: (option, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
