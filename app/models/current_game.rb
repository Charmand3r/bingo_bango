class CurrentGame
  def id
    game.id
  end
  alias :number :id

  def game
    Game.with_advisory_lock(:fetch_current_game) do
      @game ||= (Game.last || Game.create!)
    end
  end
end
