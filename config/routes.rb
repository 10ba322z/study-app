Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'pages#index'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new'
    end
  end
  get  'pages/show'
end
