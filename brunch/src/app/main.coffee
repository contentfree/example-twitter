window.bt = {}
bt.controllers = {}
bt.models = {}
bt.views = {}

# app bootstrapping on document ready
$(document).ready ->
  # init controller
  bt.controllers.main = new MainController()

  # attach the Twitter object to the namespace of our app
  # and then initialize the twitter connector
  twttr.anywhere((T) ->
    bt.T = T
    bt.views.twitterConnector = new TwitterConnectorView()
  )

  # instantiated list views
  bt.views.stream = new StreamView()
  bt.views.retweets = new RetweetsView()
  bt.views.retweeted = new RetweetedView()
  bt.views.mentioned = new MentionedView()
  bt.views.directMessages = new DirectMessagesView()
  bt.views.mine = new MineView()

  bt.tweets = {}
  bt.tweets.stream = new TweetCollection()
  bt.tweets.stream.bind("refresh", bt.views.stream.render)
  bt.tweets.retweets = new TweetCollection()
  bt.tweets.retweets.bind("refresh", bt.views.retweets.render)
  bt.tweets.retweeted = new TweetCollection()
  bt.tweets.retweeted.bind("refresh", bt.views.retweeted.render)
  bt.tweets.mentioned = new TweetCollection()
  bt.tweets.mentioned.bind("refresh", bt.views.mentioned.render)
  bt.tweets.directMessages = new TweetCollection()
  bt.tweets.directMessages.bind("refresh", bt.views.directMessages.render)
  bt.tweets.mine = new TweetCollection()
  bt.tweets.mine.bind("refresh", bt.views.mine.render)

  bt.views.navigation = new NavigationView()
  $('#NavigationView').replaceWith(bt.views.navigation.render().el)

  bt.views.statusUpdate = new StatusUpdateView()
  $('#StatusUpdateView').replaceWith(bt.views.statusUpdate.render().el)

  Backbone.history.saveLocation("home") if '' == Backbone.history.getFragment()
  Backbone.history.start()
