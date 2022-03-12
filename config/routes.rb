Rails.application.routes.draw do
  devise_for :users, controller: {
    confirmations: 'confirmations'
  }
  resources :users

  resources :posts

  #root to: 'dashboard#index'
  #get 'dashboard/index'

  root to: 'movies#index'

   resources :movies do
      resources :reviews, only: [ :new, :create ]
        end
        resources :reviews, only: [ :edit, :update, :destroy ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
