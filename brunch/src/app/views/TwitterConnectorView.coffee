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
      bt.tweets.stream.add(items)
      bt.user.retweets (items) ->
        bt.tweets.retweets.add(items)
        bt.user.retweeted (items) ->
          bt.tweets.retweeted.add(items)
          bt.user.mentions (items) ->
            bt.tweets.mentioned.add(items)
            bt.user.timeline (items) ->
              bt.tweets.mine.add(items)
              bt.user.directMessages (items) ->
              item.user = item.sender
              bt.tweets.directMessages.add(items)
