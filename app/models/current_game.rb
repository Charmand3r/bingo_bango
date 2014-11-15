class CurrentGame
  def id
    game.id
  end

  def game
    Game.last || Game.create!
  end
end
