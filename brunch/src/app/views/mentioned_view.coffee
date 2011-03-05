class MentionedView extends Backbone.View
  id: 'MentionedView'

  initialize: ->
    _.bindAll(@, "render")

  render: ->
    $(@el).html(bt.templates.list(tweets: bt.tweets.mentioned.toJSON()))
    return @
