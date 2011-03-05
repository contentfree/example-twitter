class RetweetsView extends Backbone.View
  id: 'RetweetsView'

  initialize: ->
    _.bindAll(@, "render")

  render: ->
    $(@el).html(bt.templates.list(tweets: bt.tweets.retweets.toJSON()))
    return @
