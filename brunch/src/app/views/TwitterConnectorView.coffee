class TwitterConnectorView extends Backbone.View
  id: 'TwitterConnectorView'

  events:
    'click .connect': 'connect'

  initialize: ->
    @delegateEvents(@events)
    bt.T.bind('authComplete', @authComplete)
    bt.T.bind("signOut", @signOut)
    @render()
    _.bindAll(@, "render", "connect", "authComplete")

  render: ->
    $(@el).html(bt.templates.twitterConnect())
    $('#content').append(@el)

  # triggered when auth completed successfully
  authComplete: (e, user) ->
    bt.user = user
    console.log(user)
    # let's poll for new tweets every minute
    setInterval(@poll, 60*1000)
    # since the user is logged in we can now
    # hide the connect button as it is no longer needed
    # scoped query see: http://documentcloud.github.com/backbone/#View-dollar
    @$('.connect').hide()
    @poll()

  # triggered when user logs out
  signOut: (e) ->

  connect: ->
    if bt.T.isConnected()
      @authComplete null, bt.T.currentUser
    else
      bt.T.signIn()

  poll: ->
    console.log('poll')

    bt.tweets.stream.refresh([])
    bt.user.homeTimeline (items) ->
      tweets = []
      for item in items.array
        tweets.push(TweetModel(item))
      bt.tweets.stream.add(tweets)
      bt.user.retweets (items) ->
        tweets = []
        for item in items.array
          tweets.push(TweetModel(item))
        bt.tweets.retweets.add(tweets)
        bt.user.retweeted (items) ->
          tweets = []
          for item in items.array
            tweets.push(TweetModel(item))
          bt.tweets.retweeted.add(tweets)
          bt.user.mentions (items) ->
            tweets = []
            for item in items.array
              tweets.push(TweetModel(item))
            bt.tweets.mentioned.add(tweets)
            bt.user.timeline (items) ->
              tweets = []
              for item in items.array
                tweets.push(TweetModel(item))
              bt.tweets.mine.add(tweets)
              bt.user.directMessages (items) ->
                tweets = []
                for item in items.array
                  item.user = item.sender
                  tweets.push(TweetModel(item))
              bt.tweets.directMessages.add(tweets)
