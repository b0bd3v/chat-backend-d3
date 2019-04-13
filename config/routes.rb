Rails.application.routes.draw do
  resources :conversations, only: [:index, :create, :destroy]
  resources :messages, only: [:create]
  mount ActionCable.server => '/cable'
end
