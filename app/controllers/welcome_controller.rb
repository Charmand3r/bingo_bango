class WelcomeController < ApplicationController
  def index
    @current_game = CurrentGame.new
  end
end
