class Player::Form
  include ActiveModel::Model

  attr_accessor :name

  validates :name, :presence => true

  def initialize(current_player, attributes)
    @current_player = current_player
    super(attributes)
  end

  def self.model_name
    Player.model_name
  end

  def save
    valid? && create_player && set_current_player
  end

  private

  def create_player
    @player = Player.new(name: name).tap do |player|
      player.save!
    end
  end

  def set_current_player
    @current_player.player_id = @player.id
  end
end
