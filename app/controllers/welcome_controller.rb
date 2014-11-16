class WelcomeController < ApplicationController
  def index
    @leaderboard = Leaderboard.leaders
  end
end
