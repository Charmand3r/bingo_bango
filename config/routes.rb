Rails.application.routes.draw do
  root 'welcome#index'

  resources :game, only: [ :show ] do
    resource :participation, only: [ :create ]
  end

  resource :waiting_room, only: [ :show ], controller: :waiting_room
  resource :player, only: [ :new, :create ]
end
