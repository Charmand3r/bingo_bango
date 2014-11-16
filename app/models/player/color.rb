class Player::Color
  def initialize(player)
    @player = player
  end

  def to_s
    "hsl(#{hue}, 100%, 50%)"
  end

  def hue
    "#{@player.id}#{@player.name}".hash % (360 + 1)
  end
end
