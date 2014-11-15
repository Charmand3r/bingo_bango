class PlayersController < ApplicationController
  skip_before_filter :ensure_player_set

  before_filter :prepare_player_form

  def new
  end

  def create
    if @player_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def prepare_player_form
    @player_form = Player::Form.new(current_player, params[:player])
  end
end
