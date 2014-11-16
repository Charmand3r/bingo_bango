class CurrentGame
  def game
    Game.with_advisory_lock(:current_game) do
      last_game = Game.last

      if last_game.present? && GameState.new(last_game).waiting_to_start?
        last_game
      else
        Game.create!
      end
    end
  end
end
