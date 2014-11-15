class ParticipationsController < ApplicationController
  before_filter :prepare_game

  def create
    if @game_state.waiting_for_players?
      Participation.create!(game: @game, player: current_player.player, numbers: ParticipationNumberGenerator.generate)
      redirect_to game_path(@game)
    else
      redirect_to waiting_room_path, flash: { notice: 'The game has started already' }
    end
  end

  private

  def prepare_game
    @game       = Game.find(params[:id] || params[:game_id])
    @game_state = GameState.new(@game)
  end
end
