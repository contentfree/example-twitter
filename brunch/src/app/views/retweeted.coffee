class RetweetedView extends Backbone.View
  id: 'RetweetedView'

  initialize: ->
    _.bindAll(@, "render")
    console.log 'helloooo'

  render: ->
    $(@el).html(bt.templates.list(tweets: bt.tweets.retweeted.toJSON()))
    return @
