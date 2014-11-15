class CurrentGame
  TIME_TO_START = 10

  def number
    game.id
  end

  def current_state
    in_progress? ? 'in progress' : 'waiting to start'
  end

  private 

  def in_progress?
    game.created_at < TIME_TO_START.ago
  end

  def game
    Game.last || Game.create!
  end
end
