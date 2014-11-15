class ParticipationsController < ApplicationController
  def create
    if current_game_state.waiting_for_players?
      Participation.create!(game: current_game.game, player: current_player.player)
      redirect_to game_path(current_game.game)
    else
      redirect_to waiting_room_path, flash: { notice: 'The game has started already' }
    end
  end

  private

  def current_game
    @current_game ||= CurrentGame.new
  end

  def current_game_state
    @current_game_state ||= GameState.new(current_game.game)
  end
end
