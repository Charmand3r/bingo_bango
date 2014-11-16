module PlayerHelper
  def player_tag(player)
    content_tag :span, class: 'player' do
      content_tag(:span, '', class: 'icon-user', style: "background: #{Player::Color.new(player)}") <<
      content_tag(:span, player.name, class: 'player-name')
    end
  end
end
