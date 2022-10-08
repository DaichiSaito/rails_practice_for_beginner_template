Rails.application.routes.draw do
  resources :users
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :questions

  namespace :admin do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    resources :users, only: [:index, :destroy]
    resources :questions, only: [:index, :destroy]
  end
end
