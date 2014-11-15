class CurrentGame
  TIME_TO_START = 10

  def number
    game.id
  end

  def current_state
    in_progress? ? 'in progress' : 'waiting to start'
  end

  def in_progress?
    game.created_at < TIME_TO_START.ago
  end

  def current_game_url
    url_helpers.game_path(number)
  end

  private

  def game
    Game.last || Game.create!
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end
end
