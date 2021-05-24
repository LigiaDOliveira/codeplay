Rails.application.routes.draw do
  root to: 'home#index'
  resources :docents
  resources :courses do
    resources :lessons, only: %i[new create]
  end
end
