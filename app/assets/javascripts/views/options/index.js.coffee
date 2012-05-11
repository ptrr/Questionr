class Formr.Views.OptionsIndex extends Backbone.View
  template: JST['options/index']

  initialize: ->
    @collection.on('add', @appendOption, this)
    @collection.on('change', @backEndSort, this)
    @collection.on('reset', @render, this)
    @collection.sort()

  render: ->
    $(@el).html(@template())
    @collection.each(@appendOption)
    this

  backEndSort: (option) ->
    collection = new Formr.Collections.Options()
    collection.url = collection.create_option_url(option.get('question_id'))
    collection.fetch()
    $(".option_container").sortable
      handle: '.handler'
      update: (el, ui) ->
        $(this).find('li > a').each (i) ->
          id = $(this).attr('data-option-id')

          item = collection.get(id)
          console.log(item)
          if item.get('order') != i+1 then item.save order: i+1
        collection.sort()
        collection.fetch()


  appendOption: (option) ->
    collection = new Formr.Collections.Options()
    collection.url = collection.create_option_url(option.get('question_id'))
    view = new Formr.Views.Option(model: option)
    collection.fetch()
    $('#question_options_'+option.get('question_id')).append(view.render().el)
    $(".option_container").sortable
      handle: '.handler'
      update: (el, ui) ->
        $(this).find('li > a.option_label').each (i) ->
          id = $(this).attr('data-option-id')
          console.log(collection)
          item = collection.get(id)
          console.log(item)
          if item.get('order') != i+1 then item.save order: i+1
        collection.sort()
        collection.fetch()

  handleError: (question, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages


