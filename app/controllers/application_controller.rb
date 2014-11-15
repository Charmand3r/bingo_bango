class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :ensure_player_set

  def ensure_player_set
    if current_player.blank?
      redirect_to new_player_path
    end
  end

  def current_player
    @current_player ||= CurrentPlayer.new(session)
  end
  helper_method :current_player
end
