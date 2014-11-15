class ParticipationsController < ApplicationController
  def create
    current_game = CurrentGame.new
    if current_game.in_progress?
      redirect_to waiting_room_path, flash: { notice: 'The game has started already' }
    else
      Participation.create!(game: current_game.game, player: current_player.player)
      redirect_to game_path(current_game.game)
    end
  end
end
