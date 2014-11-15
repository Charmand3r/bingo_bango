# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require_tree .
#
#
#
#
#

class GameUpdater
  constructor: (gameId) ->
    @gameId = gameId

  run: ->
    $.ajax( url: "/games/#{@gameId}/info").done ( (data) =>
      @_updateLastNumber(data.number)
      @_updatePlayerCount(data.players_count)
      @_updateGameState(data.state)

      if data.state == 'finished'
        window.location.reload()
      else
        setTimeout( (=> @run() ), 500)
    )

  _updateLastNumber: (number) ->
    if number?
      $('.last-game-number-wrapper').show()
      $('.last-game-number').text(number)

  _updatePlayerCount: (playersCount) ->
    $('.players-count').text(playersCount)

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
        $('.bingo').show()
    )

$(document).ready ->
  if $('body').data('game-id') != ''
    unless $('body').data('game-state') == 'finished'
      new GameUpdater($('body').data('game-id')).run()

  $('[data-mark-number]').click (e) ->
    e.preventDefault()
    new NumberMarker($(e.target)).mark()
