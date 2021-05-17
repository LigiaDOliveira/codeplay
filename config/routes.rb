Rails.application.routes.draw do
  root to: 'home#index'
  resources :courses
  resources :docents
end
