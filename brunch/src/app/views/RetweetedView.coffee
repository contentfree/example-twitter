class RetweetedView extends Backbone.View
  id: 'RetweetedView'

  initialize: ->
    _.bindAll(@, "render")

  render: ->
    $(@el).html(bt.templates.list(tweets: bt.tweets.retweeted.toJSON()))
    return @
