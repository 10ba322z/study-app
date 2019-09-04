Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    authenticated :user do
      root :to => 'users#index'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new'
    end
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users,         only: [:index, :show]
  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
end
