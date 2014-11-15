Rails.application.routes.draw do
  root 'welcome#index'

  resources :game, only: [ :show ] do
    resource :participation, only: [ :new, :create ]
  end

  resource :waiting_room, only: [ :show ]
  resource :player, only: [ :new, :create ]
end
