(function() {
  var GameUpdater, NumberMarker, defaultVoice, interval, setDefaultVoice, speakPhrases,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  speakPhrases = false;

  defaultVoice = null;

  interval = null;

  setDefaultVoice = function() {
    var voice, _i, _len, _ref, _results;
    _ref = speechSynthesis.getVoices();
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      voice = _ref[_i];
      if (voice.name === 'Alex') {
        defaultVoice = voice;
        _results.push(clearInterval(interval));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  if (typeof speechSynthesis !== "undefined" && speechSynthesis !== null) {
    setInterval(setDefaultVoice, 100);
  }

  GameUpdater = (function() {
    GameUpdater.prototype._number = null;

    function GameUpdater(gameId) {
      this.run = __bind(this.run, this);
      this.gameId = gameId;
    }

    GameUpdater.prototype.run = function() {
      return $.ajax({
        url: "/games/" + this.gameId + "/info"
      }).done((function(_this) {
        return function(data) {
          _this._updateLastNumber(data.number);
          _this._updatePlayers(data.players);
          _this._updateGameState(data.state);
          if (data.state === 'finished') {
            return window.location.reload();
          } else {
            return setTimeout(_this.run, 750);
          }
        };
      })(this));
    };

    GameUpdater.prototype._announceNumber = function(number) {
      var message, phrase, words;
      console.log('_announceNumber', number, this._number, defaultVoice);
      if (number !== this._number) {
        this._number = number;
        phrase = window.BingBangoPhrases[number];
        if (phrase) {
          words = speakPhrases ? "" + number + " - " + phrase : number;
          message = new SpeechSynthesisUtterance(words);
          message.lang = 'en-EN';
          message.rate = 1.6;
          if (defaultVoice != null) {
            message.voice = defaultVoice;
          }
          return speechSynthesis.speak(message);
        }
      }
    };

    GameUpdater.prototype._updateLastNumber = function(number) {
      if (number != null) {
        setTimeout((function(_this) {
          return function() {
            if (typeof speechSynthesis !== "undefined" && speechSynthesis !== null) {
              return _this._announceNumber(number);
            }
          };
        })(this), 0);
        $('.last-game-number-wrapper').show();
        return $('.last-game-number').text(number);
      }
    };

    GameUpdater.prototype._updatePlayers = function(players) {
      $('.players-count').text(players.length);
      $('.players-list').empty();
      return $.each(players, (function(_this) {
        return function(index, player) {
          return $('.players-list').append(_this._playerTag(player));
        };
      })(this));
    };

    GameUpdater.prototype._playerTag = function(player) {
      return "<span class=\"player\">\n  <span class=\"icon-user\" style=\"background: " + player.color + "\"></span>\n  <span class=\"player-name\">" + player.name + "</span>\n</span>";
    };

    GameUpdater.prototype._updateGameState = function(gameState) {
      return $('.game-state').text(gameState.replace(/_/g, ' '));
    };

    return GameUpdater;

  })();

  NumberMarker = (function() {
    function NumberMarker(link) {
      this.link = link;
    }

    NumberMarker.prototype.mark = function() {
      return $.ajax({
        url: this.link.attr('href')
      }).done(((function(_this) {
        return function() {
          _this.link.removeClass('number').addClass('number--active');
          if ($('.number--active').length === 15) {
            return $('.win-button').show();
          }
        };
      })(this)));
    };

    return NumberMarker;

  })();

  $(document).ready(function() {
    if ($('body').data('game-id') !== '') {
      if ($('body').data('game-state') !== 'finished') {
        new GameUpdater($('body').data('game-id')).run();
      }
    }
    return $('[data-mark-number]').click(function(e) {
      e.preventDefault();
      return new NumberMarker($(e.target)).mark();
    });
  });

}).call(this);
