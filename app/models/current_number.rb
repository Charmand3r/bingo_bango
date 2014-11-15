class CurrentNumber
  DRAW_TIME = (1.5).seconds

  def initialize(game)
    @game       = game
    @game_state = GameState.new(@game)
  end

  def number
    @game.with_lock do
      if time_to_draw_new_number?
        new_number.tap do |number|
          @game.update_attributes(drawn_numbers: @game.drawn_numbers + Array(number))
        end
      else
        @game.drawn_numbers.last
      end
    end
  end

  private

  def new_number
    available_numbers.sample
  end

  def available_numbers
    @available_numbers ||= (1..90).to_a - @game.drawn_numbers
  end

  def time_to_draw_new_number?
    @game_state.in_progress? && available_numbers.present? && @game.updated_at < DRAW_TIME.ago
  end
end
