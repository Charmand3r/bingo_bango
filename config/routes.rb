Rails.application.routes.draw do
  root 'welcome#index'

  resources :game, only: [ :show ]
  resource :waiting_room, only: [ :show ]
end
