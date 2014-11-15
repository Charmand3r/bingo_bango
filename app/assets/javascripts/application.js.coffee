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
    $.ajax(
      url: "/games/#{@gameId}/info"
    ).done ( (data) =>
      @_updateLastNumber(data.number)
      setTimeout( (=> @run() ), 500)
    )

  _updateLastNumber: (number) ->
    $('.last-game-number').text(number)

$(document).ready ->
  if $('body').data('game-id') != ''
    new GameUpdater($('body').data('game-id')).run()
