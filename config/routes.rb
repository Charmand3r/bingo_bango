Rails.application.routes.draw do
  root 'welcome#index'

  resources :games, only: [ :show ] do
    resource :participations, only: [ :create ]
    get :info
    get :mark_number
  end

  resource :waiting_room, only: [ :show ], controller: :waiting_room
  resource :player, only: [ :new, :create ]
end
