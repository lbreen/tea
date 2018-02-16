Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :groups do
    resources :group_members, only: [:new, :create, :destroy]
  end

  resources :friendships, only: [ :index, :update ]

  resources :users, only: [] do
    resources :friendships, only: [:create]
  end

  get 'profile/:id', to: 'pages#user_profile', as: :user_profile


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
