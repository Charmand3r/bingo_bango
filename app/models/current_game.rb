class CurrentGame
  TIME_TO_START = 10

  def id
    game.id
  end
  alias :number :id

  def current_state
    in_progress? ? 'in progress' : 'waiting to start'
  end

  def in_progress?
    game.created_at < TIME_TO_START.ago
  end

  private

  def game
    Game.last || Game.create!
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end
end
