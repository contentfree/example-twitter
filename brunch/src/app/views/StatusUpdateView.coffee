class StatusUpdateView extends Backbone.View
  id: 'StatusUpdateView'

  events:
    'keypress textarea': 'updateCharCount'
    'keyup textarea': 'updateCharCount'
    'keydown textarea': 'updateCharCount'
    'change textarea': 'updateCharCount'
    'paste textarea': 'updateCharCount'
    'click .tweet-button': 'tweet'

  updateCharCount: (e) ->
    tweetLength = e.currentTarget.value.length
    charsLeft = 140 - tweetLength
    console.log(charsLeft)
    this.$('.char-count').html(charsLeft)

  render: ->
    $(@el).html(bt.templates.statusUpdate())

    bt.followees = ['@thedeftone', '@0xx0', '@andreasklinger', '@msch', '@gruber']
    split = (val) -> val.split( /\s+/ )
    extractLast = (term) -> split(term).pop()
    
    options =
      minLength: 1
      multiple: true
      multipleSeparator: " "
      source: bt.followees
      focus: -> false
      select: (event, ui) ->
        terms = split(this.value)
        # remove the current input
        terms.pop()
        # add the selected item
        terms.push(ui.item.value)
        # add placeholder to get the comma-and-space at the end
        terms.push("")
        this.value = terms.join(" ")
        return false
      source: (request, response) ->
        # delegate back to autocomplete, but extract the last term
        response($.ui.autocomplete.filter(bt.followees, extractLast(request.term)))

    this.$('textarea').autocomplete(options)
    return @

  tweet: (e) ->
    # we actually don't want the browser to
    # do a form submit
    e.preventDefault()
    textarea = this.$('textarea')
    message = textarea.val()
    console.log('tweet:')
    console.log(message)
    bt.T.Status.update(message)
    # clear the textarea
    textarea.val('')
