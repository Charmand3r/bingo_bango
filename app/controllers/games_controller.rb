class GamesController < ApplicationController
  before_filter :prepare_current_game
  before_filter :prepare_participation

  def show
  end

  def info
    render :json => { :number => @number = CurrentNumber.new(@game).number, :state => @game_state.state }
  end

  private

  def prepare_current_game
    @game       = Game.find(params[:id] || params[:game_id])
    @game_state = GameState.new(@game)
  end

  def prepare_participation
    @participation ||= Participation.find_by(player_id: current_player.player.id, game_id: @game.id)
  end
end
