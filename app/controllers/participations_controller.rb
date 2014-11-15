class ParticipationsController < ApplicationController
  before_filter :prepare_game

  def create
    if Participation.find_by(player_id: current_player.player.id, game_id: @game.id).blank?
      Participation.create!(game: @game, player: current_player.player, numbers: ParticipationNumberGenerator.generate)
    end

    redirect_to game_path(@game)
  end

  private

  def prepare_game
    @game       = CurrentGame.new.game
    @game_state = GameState.new(@game)
  end
end
