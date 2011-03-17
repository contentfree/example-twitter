['_trackPageview', msg.replace(/route:/, '')]);
        }
      });
    }
    MainController.prototype.home = function() {};
    MainController.prototype.stream = function() {
      $('#list').html(bt.views.stream.render().el);
      return bt.T('#list').hovercards();
    };
    MainController.prototype.mentioned = function() {
      $('#list').html(bt.views.mentioned.render().el);
      return bt.T('#list').hovercards();
    };
    MainController.prototype.directMessages = function() {
      $('#list').html(bt.views.directMessages.render().el);
      return bt.T('#list').hovercards();
    };
    MainController.prototype.mine = function() {
      $('#list').html(bt.views.mine.render().el);
      return bt.T('#list').hovercards();
    };
    MainController.prototype.retweeted = function() {
      $('#list').html(bt.views.retweeted.render().el);
      return bt.T('#list').hovercards();
    };
    MainController.prototype.retweets = function() {
      $('#list').html(bt.views.retweets.render().el);
      return bt.T('#list').hovercards();
    };
    MainController.prototype.settings = function() {};
    return MainController;
  })();
  DirectMessagesView = (function() {
    function DirectMessagesView() {
      DirectMessagesView.__super__.constructor.apply(this, arguments);
    }
    __extends(DirectMessagesView, Backbone.View);
    DirectMessagesView.prototype.id = 'DirectMessagesView';
    DirectMessagesView.prototype.initialize = function() {
      return _.bindAll(this, "render");
    };
    DirectMessagesView.prototype.render = function() {
      $(this.el).html(bt.templates.list({
        tweets: bt.tweets.directMessages.toJSON()
      }));
      return this;
    };
    return DirectMessagesView;
  })();
  MentionedView = (function() {
    function MentionedView() {
      MentionedView.__super__.constructor.apply(this, arguments);
    }
    __extends(MentionedView, Backbone.View);
    MentionedView.prototype.id = 'MentionedView';
    MentionedView.prototype.initialize = function() {
      return _.bindAll(this, "render");
    };
    MentionedView.prototype.render = function() {
      $(this.el).html(bt.templates.list({
        tweets: bt.tweets.mentioned.toJSON()
      }));
      return this;
    };
    return MentionedView;
  })();
  MineView = (function() {
    function MineView() {
      MineView.__super__.constructor.apply(this, arguments);
    }
    __extends(MineView, Backbone.View);
    MineView.prototype.id = 'MineView';
    MineView.prototype.initialize = function() {
      return _.bindAll(this, "render");
    };
    MineView.prototype.render = function() {
      $(this.el).html(bt.templates.list({
        tweets: bt.tweets.mine.toJSON()
      }));
      return this;
    };
    return MineView;
  })();
  NavigationView = (function() {
    function NavigationView() {
      NavigationView.__super__.constructor.apply(this, arguments);
    }
    __extends(NavigationView, Backbone.View);
    NavigationView.prototype.id = 'NavigationView';
    NavigationView.prototype.events = {
      'click li': 'navigate'
    };
    NavigationView.prototype.render = function() {
      $(this.el).html(bt.templates.navigation());
      return this;
    };
    NavigationView.prototype.navigate = function(e) {
      var nav;
      this.$('li').removeClass('selected');
      $(e.currentTarget).addClass('selected');
      nav = $(e.currentTarget).data('nav');
      bt.controllers.main[nav]();
      return Backbone.history.saveLocation(nav);
    };
    return NavigationView;
  })();
  RetweetedView = (function() {
    function RetweetedView() {
      RetweetedView.__super__.constructor.apply(this, arguments);
    }
    __extends(RetweetedView, Backbone.View);
    RetweetedView.prototype.id = 'RetweetedView';
    RetweetedView.prototype.initialize = function() {
      _.bindAll(this, "render");
      return console.log('helloooo');
    };
    RetweetedView.prototype.render = function() {
      $(this.el).html(bt.templates.list({
        tweets: bt.tweets.retweeted.toJSON()
      }));
      return this;
    };
    return RetweetedView;
  })();
  RetweetsView = (function() {
    function RetweetsView() {
      RetweetsView.__super__.constructor.apply(this, arguments);
    }
    __extends(RetweetsView, Backbone.View);
    RetweetsView.prototype.id = 'RetweetsView';
    RetweetsView.prototype.initialize = function() {
      return _.bindAll(this, "render");
    };
    RetweetsView.prototype.render = function() {
      $(this.el).html(bt.templates.list({
        tweets: bt.tweets.retweets.toJSON()
      }));
      return this;
    };
    return RetweetsView;
  })();
  StatusUpdateView = (function() {
    function StatusUpdateView() {
      StatusUpdateView.__super__.constructor.apply(this, arguments);
    }
    __extends(StatusUpdateView, Backbone.View);
    StatusUpdateView.prototype.id = 'StatusUpdateView';
    StatusUpdateView.prototype.events = {
      'keypress textarea': 'updateCharCount',
      'keyup textarea': 'updateCharCount',
      'keydown textarea': 'updateCharCount',
      'change textarea': 'updateCharCount',
      'paste textarea': 'updateCharCount',
      'click .tweet-button': 'tweet'
    };
    StatusUpdateView.prototype.updateCharCount = function(e) {
      var charsLeft, tweetLength;
      tweetLength = e.currentTarget.value.length;
      charsLeft = 140 - tweetLength;
      console.log(charsLeft);
      return this.$('.char-count').html(charsLeft);
    };
    StatusUpdateView.prototype.render = function() {
      var extractLast, options, split;
      $(this.el).html(bt.templates.statusUpdate());
      bt.followees = ['@thedeftone', '@0xx0', '@andreasklinger', '@msch', '@gruber'];
      split = function(val) {
        return val.split(/\s+/);
      };
      extractLast = function(term) {
        return split(term).pop();
      };
      options = {
        minLength: 1,
        multiple: true,
        multipleSeparator: " ",
        source: bt.followees,
        focus: function() {
          return false;
        },
        select: function(event, ui) {
          var terms;
          terms = split(this.value);
          terms.pop();
          terms.push(ui.item.value);
          terms.push("");
          this.value = terms.join(" ");
          return false;
        },
        source: function(request, response) {
          return response($.ui.autocomplete.filter(bt.followees, extractLast(request.term)));
        }
      };
      this.$('textarea').autocomplete(options);
      return this;
    };
    StatusUpdateView.prototype.tweet = function(e) {
      var message, textarea;
      e.preventDefault();
      textarea = this.$('textarea');
      message = textarea.val();
      console.log('tweet:');
      console.log(message);
      bt.T.Status.update(message);
      return textarea.val('');
    };
    return StatusUpdateView;
  })();
  StreamView = (function() {
    function StreamView() {
      this.render = __bind(this.render, this);;      StreamView.__super__.constructor.apply(this, arguments);
    }
    __extends(StreamView, Backbone.View);
    StreamView.prototype.id = 'StreamView';
    StreamView.prototype.render = function() {
      console.log('render stream');
      $(this.el).html(bt.templates.list({
        tweets: bt.tweets.stream.toJSON()
      }));
      return this;
    };
    return StreamView;
  })();
  TwitterConnectorView = (function() {
    function TwitterConnectorView() {
      this.poll = __bind(this.poll, this);;
      this.connect = __bind(this.connect, this);;
      this.authComplete = __bind(this.authComplete, this);;
      this.render = __bind(this.render, this);;      TwitterConnectorView.__super__.constructor.apply(this, arguments);
    }
    __extends(TwitterConnectorView, Backbone.View);
    TwitterConnectorView.prototype.id = 'TwitterConnectorView';
    TwitterConnectorView.prototype.events = {
      'click .connect': 'connect'
    };
    TwitterConnectorView.prototype.initialize = function() {
      this.delegateEvents(this.events);
      bt.T.bind('authComplete', this.authComplete);
      bt.T.bind("signOut", this.signOut);
      return this.render();
    };
    TwitterConnectorView.prototype.render = function() {
      $(this.el).html(bt.templates.twitterConnect());
      return $('#content').append(this.el);
    };
    TwitterConnectorView.prototype.authComplete = function(e, user) {
      bt.user = user;
      console.log(user);
      setInterval(this.poll, 3 * 60 * 1000);
      this.$('.connect').hide();
      return this.poll();
    };
    TwitterConnectorView.prototype.signOut = function(e) {};
    TwitterConnectorView.prototype.connect = function() {
      if (bt.T.isConnected()) {
        return this.authComplete(null, bt.T.currentUser);
      } else {
        return bt.T.signIn();
      }
    };
    TwitterConnectorView.prototype.poll = function() {
      console.log('poll');
      return bt.user.homeTimeline(function(items) {
        bt.tweets.stream.refresh(items.array);
        return bt.user.retweets(function(items) {
          bt.tweets.retweets.refresh(items.array);
          return bt.user.retweeted(function(items) {
            bt.tweets.retweeted.refresh(items.array);
            return bt.user.mentions(function(items) {
              bt.tweets.mentioned.refresh(items.array);
              return bt.user.timeline(function(items) {
                bt.tweets.mine.refresh(items.array);
                return bt.user.directMessages(function(items) {
                  var item, _i, _len, _ref;
                  _ref = items.array;
                  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                    item = _ref[_i];
                    item.user = item.sender;
                  }
                  return bt.tweets.directMessages.refresh(items.array);
                });
              });
            });
          });
        });
      });
    };
    return TwitterConnectorView;
  })();
}).call(this);
