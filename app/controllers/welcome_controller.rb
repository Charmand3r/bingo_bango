class WelcomeController < ApplicationController
  def index
    @current_game       = CurrentGame.new
    @current_game_state = CurrentGameState.new(@current_game.game)
  end
end
