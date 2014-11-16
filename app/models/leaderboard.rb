class Leaderboard
  def self.leaders
    Game.where('winner_id IS NOT NULL').group(:winner).order('count_all DESC').count.first(5)
  end
end
