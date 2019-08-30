Rails.application.routes.draw do
  get 'chart_sample/index'
  devise_for :users
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
