Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only:[:new, :create, :index]
  resources :questions do
      collection do
        get :solved
        get :unsolved
      end
      
      member do
        post :solve
      end
    resources :answers, only: [:create, :destroy]
  end

  namespace:admin do
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    resources :users, only: [:index, :destroy]
    resources :questions, only: [:index, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
