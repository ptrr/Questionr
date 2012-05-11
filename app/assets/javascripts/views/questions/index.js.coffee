class Formr.Views.QuestionsIndex extends Backbone.View
  template: JST['questions/index']

  events:
    'click .add_question': 'createQuestion'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendQuestion, this)
    @collection.on('change', @backEndSort, this)
    @collection.sort()

  render: (e) ->
    $(@el).html(@template())
    @collection.each(@appendQuestion)
    this

  backEndSort: (question) ->
    collection = new Formr.Collections.Questions()
    #collection.url = collection.create_option_url(option.get('id'))
    collection.fetch()
    $("#form_container").sortable
      update: (el, ui) ->
        $(this).find('div.control-group .question_wrapper').each (i) ->
          id = $(this).attr('data-id')
          item = collection.get(id)
          # console.log(item.get('order'))
          if item.get('order') != i+1 then item.save order: i+1
        collection.sort()
        collection.fetch()

  createQuestion: (e) ->
    attributes = title: e.target.attributes[1].nodeValue, question_type: e.target.attributes[1].nodeValue, order: @collection.length
    @collection.create attributes,
      wait: true
      success: (model, response) ->
        console.log(response)
      error: @handleError

  appendQuestion: (question) ->
    collection = new Formr.Collections.Questions()
    # collection.url = collection.create_option_url(option.get('question_id'))
    collection.fetch()
    view = new Formr.Views.Question(model: question, collection: @question_options)
    @$('#form_container').append(view.render().el).children().animate({
    backgroundColor: '#fff'}, 2000)
    $("#form_container").sortable
      update: (el, ui) ->
        $(this).find('div.control-group .question_wrapper').each (i) ->
          id = $(this).attr('data-id')
          console.log('id:' + id)
          item = collection.get(id)
          console.log(collection.url)
          console.log('order'+ item.get('order'))
          if item.get('order') != i+1 then item.save order: i+1
        collection.sort()
        collection.fetch()

  handleError: (question, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
