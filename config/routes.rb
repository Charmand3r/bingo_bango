Rails.application.routes.draw do
  root 'welcome#index'

  resources :games, only: [ :show ] do
    resource :participations, only: [ :create ]
  end

  resource :waiting_room, only: [ :show ], controller: :waiting_room
  resource :player, only: [ :new, :create ]
end
