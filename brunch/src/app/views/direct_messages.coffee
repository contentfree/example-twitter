class DirectMessagesView extends Backbone.View
  id: 'DirectMessagesView'

  initialize: ->
    _.bindAll(@, "render")

  render: ->
    $(@el).html(bt.templates.list(tweets: bt.tweets.directMessages.toJSON()))
    return @
