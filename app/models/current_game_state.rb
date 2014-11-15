class CurrentGameState
  TIME_TO_START = 10

  module States
    WAITING_FOR_PLAYERS = :waiting_for_players
  end

  def initialize(game)
    @game = game
  end

  def state
    if @game.created_at > TIME_TO_START.ago
      States::WAITING_FOR_PLAYERS
    else
      # raise 'unknown state'
    end
  end

  def waiting_for_players?
    state == CurrentGameState::States::WAITING_FOR_PLAYERS
  end

  def name
    state.to_s.titleize
  end

  def progress
    Game.with_advisory_lock(:game_state) do
    end
  end

  def name
  end
end
