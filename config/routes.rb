Rails.application.routes.draw do
  root 'stations#index'
  resources :stations, only: [:index, :create]
end
