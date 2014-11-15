class CurrentPlayer
  def initialize(session)
    @session = session
  end

  def blank?
    player.blank?
  end

  def player_id=(player_id)
    @session[:current_player_id] = player_id
  end

  private

  def player
    @session[:current_player_id].present? && Player.find_by(id: @session[:current_player_id])
  end
end
