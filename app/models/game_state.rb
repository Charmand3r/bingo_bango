class GameState
  TIME_TO_START = 10

  module States
    WAITING_FOR_PLAYERS = :waiting_for_players
    FINISHED            = :finished
    IN_PROGRESS         = :in_progress
  end

  def initialize(game)
    @game = game
  end

  def state
    if @game.created_at > TIME_TO_START.ago
      States::WAITING_FOR_PLAYERS
    elsif @game.winner.present?
      States::FINISHED
    else
      States::IN_PROGRESS
    end
  end

  def waiting_for_players?
    state == GameState::States::WAITING_FOR_PLAYERS
  end

  def in_progress?
    state == GameState::States::IN_PROGRESS
  end

  def name
    state.to_s.titleize
  end

  def progress
    Game.with_advisory_lock(:game_state) do
    end
  end
end
