class MainController extends Backbone.Controller
  routes :
    "home": "home"
    "stream": "stream"
    "mentioned": "mentioned"
    "directMessages": "directMessages"
    "mine": "mine"
    "retweeted": "retweeted"
    "retweets": "retweets"
    "settings": "settings"

  constructor: ->
    super
    @bind "all", (msg) ->
      # trigger google analytics
      if _gaq?
        _gaq.push ['_trackPageview', msg.replace(/route:/,'')]

  home: ->
    # attach the Twitter object to the namespace of our app
    # and then initialize the twitter connector
    twttr.anywhere((T) ->
      bt.T = T
      bt.views.twitterConnector = new TwitterConnectorView()
    )

  stream: ->
    $('#list').html(bt.views.stream.render().el)
    bt.T('#list').hovercards()

  mentioned: ->
    $('#list').html(bt.views.mentioned.render().el)
    bt.T('#list').hovercards()

  directMessages: ->
    $('#list').html(bt.views.directMessages.render().el)
    bt.T('#list').hovercards()

  mine: ->
    $('#list').html(bt.views.mine.render().el)
    bt.T('#list').hovercards()

  retweeted: ->
    $('#list').html(bt.views.retweeted.render().el)
    bt.T('#list').hovercards()

  retweets: ->
    $('#list').html(bt.views.retweets.render().el)
    bt.T('#list').hovercards()

  settings: ->
