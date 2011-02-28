class MineView extends Backbone.View
  id: 'MineView'

  initialize: ->
    _.bindAll(@, "render")

  render: ->
    $(@el).html(bt.templates.list(tweets: bt.tweets.mine.toJSON()))
    return @
