#= require jquery
#= require jquery_ujs
#= require _phrases
#= require_tree .

speakPhrases = false

# OMG the voice api isn't available on load, have to poll until it's ready!? :(
defaultVoice = null
interval = null
setDefaultVoice = ->
  for voice in speechSynthesis.getVoices()
    if voice.name == 'Alex'
      defaultVoice = voice
      clearInterval(interval)
setInterval(setDefaultVoice, 100) if speechSynthesis?

class GameUpdater
  _number: null

  constructor: (gameId) ->
    @gameId = gameId

  run: =>
    $.ajax(url: "/games/#{@gameId}/info").done (data) =>
      @_updateLastNumber(data.number)
      @_updatePlayers(data.players)
      @_updateGameState(data.state)

      if data.state == 'finished'
        window.location.reload()
      else
        setTimeout(@run, 750)

  _announceNumber: (number) ->
    console.log '_announceNumber', number, @_number, defaultVoice
    if number isnt @_number
      @_number = number
      phrase = window.BingBangoPhrases[number]
      if phrase
        words = if speakPhrases
          "#{number} - #{phrase}"
        else
          number
        message = new SpeechSynthesisUtterance(words)
        message.lang = 'en-EN'
        message.rate = 1.6
        message.voice = defaultVoice if defaultVoice?
        speechSynthesis.speak message

  _updateLastNumber: (number) ->
    if number?
      # @_announceNumber(number) if speechSynthesis?
      $('.last-game-number-wrapper').show()
      $('.last-game-number').text(number)

  _updatePlayers: (players) ->
    $('.players-count').text(players.length)
    $('.players-list').empty()

    $.each players, (index, player) =>
      $('.players-list').append(@_playerTag(player))

  _playerTag: (player) ->
    """
      <span class="player">
        <span class="icon-user" style="background: #{player.color}"></span>
        <span class="player-name">#{player.name}</span>
      </span>
    """

  _updateGameState: (gameState) ->
    $('.game-state').text(gameState.replace(/_/g, ' '))

class NumberMarker
  constructor: (link) ->
    @link = link

  mark: ->
    $.ajax( url: @link.attr('href')).done ( =>
      @link.removeClass('number').addClass('number--active')
      # LOL HARDCODED AT FIFTEEN
      if $('.number--active').length == 15
        $('.win-button').show()
    )

$(document).ready ->
  if $('body').data('game-id') != ''
    unless $('body').data('game-state') == 'finished'
      new GameUpdater($('body').data('game-id')).run()

  $('[data-mark-number]').click (e) ->
    e.preventDefault()
    new NumberMarker($(e.target)).mark()
