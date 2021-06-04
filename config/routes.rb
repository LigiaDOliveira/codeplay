Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :docents
  resources :courses do
    resources :lessons, only: %i[new create]
  end
end
