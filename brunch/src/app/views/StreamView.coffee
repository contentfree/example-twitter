class StreamView extends Backbone.View
  id: 'StreamView'

  # to make sure that our render function
  # behaves as expected even if it is called
  # because of the 'add' event of the collection
  # we use coffeescript's fat arrow to define it.
  # this ensures that 'this' inside the render function
  # always refers to the view's instance
  # http://jashkenas.github.com/coffee-script/#fat_arrow
  render: =>
    console.log('render stream')
    $(@el).html(bt.templates.list(tweets: bt.tweets.stream.toJSON()))
    return @
