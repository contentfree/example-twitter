class TwitterConnectorView extends Backbone.View
  id: 'TwitterConnectorView'

  events:
    'click .connect': 'connect'

  initialize: ->
    @delegateEvents(@events)
    bt.T.bind('authComplete', @authComplete)
    bt.T.bind("signOut", @signOut)
    @render()

  render: =>
    $(@el).html(bt.templates.twitterConnect())
    $('#content').append(@el)

  # triggered when auth completed successfully
  authComplete: (e, user) =>
    bt.user = user
    console.log(user)
    # let's poll for new tweets every 3 minutes
    setInterval(@poll, 3*60*1000)
    # since the user is logged in we can now
    # hide the connect button as it is no longer needed
    # scoped query see: http://documentcloud.github.com/backbone/#View-dollar
    @$('.connect').hide()
    @poll()

  # triggered when user logs out
  signOut: (e) ->

  connect: =>
    if bt.T.isConnected()
      @authComplete null, bt.T.currentUser
    else
      bt.T.signIn()

  poll: =>
    console.log('poll')
    bt.user.homeTimeline (items) ->
      bt.tweets.stream.refresh(items.array)
      bt.user.retweets (items) ->
        bt.tweets.retweets.refresh(items.array)
        bt.user.retweeted (items) ->
          bt.tweets.retweeted.refresh(items.array)
          bt.user.mentions (items) ->
            bt.tweets.mentioned.refresh(items.array)
            bt.user.timeline (items) ->
              bt.tweets.mine.refresh(items.array)
              bt.user.directMessages (items) ->
                for item in items.array
                  item.user = item.sender
                bt.tweets.directMessages.refresh(items.array)
