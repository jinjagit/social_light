Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#home'
  get    '/signup',  to: 'users#new'
  get     '/login',  to: 'sessions#new'
  post    '/login',  to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/events',  to: 'events#new'
  resources :users
  resources :events, only: [:new, :create]
end
