class CurrentGame
  def id
    game.id
  end

  def game
    @game ||= begin
      Game.with_advisory_lock(:fetch_current_game) do
        Game.last || Game.create!
      end
    end
  end
end
