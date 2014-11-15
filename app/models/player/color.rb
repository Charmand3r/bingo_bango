class Player::Color
  def initialize(player)
    @player = player
  end

  def to_s
    "hsl(#{hue}, 100%, 50%)"
  end

  private

  def hue
    @player.name.hash % (360 + 1)
  end
end
