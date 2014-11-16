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
      @_updatePlayers(data.players)
      @_updateGameState(data)

      if data.state == 'finished'
        window.location.reload()
      else
        setTimeout( (=> @run() ), 750)
    )

  _updateLastNumber: (number) ->
    if number?
      $('.last-game-number-wrapper').show()
      $('.last-game-number').text(number)

  _updatePlayers: (players) ->
    $('.players-count').text(players.length)
    $('.players-list').empty()

    $.each(players, ( (index, player) ->
      $('.players-list').append("<span style='background-color: #{player.color}'>#{player.name}</span><br />")
    ) )

  _updateGameState: (data) ->
    $('.game-state').text(data.state.replace(/_/g, ' '))
    if data.state == 'waiting_to_start'
      diff = parseInt((new Date(data.game_start * 1000) - new Date()) / 1000.0)
      if diff > 0
        # LOL HARDCODED AT 2 PLAYERS!!!!!~!!!
        if data.players.length < 2
          $('.game-state').append("<span class='wait-message'> (Game will begin in #{diff} seconds if there are 2 or more players)</span>")
        else
          $('.game-state').append("<span class='wait-message'> (Game will begin in #{diff} seconds)</span>")
      else
        $('.game-state').append("<span class='wait-message'> (Game will begin when another player joins)</span>")


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
