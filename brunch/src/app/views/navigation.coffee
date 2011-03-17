class NavigationView extends Backbone.View
  id: 'NavigationView'

  events:
    'click li': 'navigate'

  render: ->
    $(@el).html(bt.templates.navigation())
    return @

  navigate: (e) ->
    @$('li').removeClass('selected')
    $(e.currentTarget).addClass('selected')
    # extract where to navigate from the
    # data attribute which we added to our li tags
    # see html5 data attributes
    # http://dev.w3.org/html5/spec/elements.html#embedding-custom-non-visible-data-with-the-data-attributes
    # see jquery documentation
    # http://api.jquery.com/data/
    nav = $(e.currentTarget).data('nav')

    # call the corresponding controller function with the nav point's name
    bt.controllers.main[nav]()
    # update the hash fragment in the address bar
    Backbone.history.saveLocation(nav)
