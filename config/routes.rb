Rails.application.routes.draw do
  root 'welcome#index'

  resources :games, only: [ :show ] do
    get :info
    get :mark_number
    post :bingo
  end

  resource :participations, only: [ :create ]

  resource :waiting_room, only: [ :show ], controller: :waiting_room
  resource :player, only: [ :new, :create ]
end
