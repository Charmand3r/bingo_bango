class GameState
  TIME_TO_START    = 30.seconds
  MIN_PARTICIPANTS = 2

  module States
    WAITING_TO_START = :waiting_to_start
    FINISHED         = :finished
    IN_PROGRESS      = :in_progress
  end

  def initialize(game)
    @game = game
  end

  def state
    if @game.winner.present?
      States::FINISHED
    elsif @game.created_at > TIME_TO_START.ago || @game.participations.size < MIN_PARTICIPANTS
      States::WAITING_TO_START
    else
      States::IN_PROGRESS
    end
  end

  def waiting_to_start?
    state == GameState::States::WAITING_TO_START
  end

  def in_progress?
    state == GameState::States::IN_PROGRESS
  end

  def finished?
    state == GameState::States::FINISHED
  end

  def name
    state.to_s.titleize
  end

  def game_start_unix_time
    (@game.created_at + TIME_TO_START).to_i
  end
end
