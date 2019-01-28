Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  # authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  # end

  root to: 'pages#home'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :groups do
    resources :group_members, only: [:new, :create, :destroy]

    resources :messages, only: [ :create, :index ]
  end

  resources :friendships, only: [ :index, :update ]

  resources :users, only: [] do
    resources :friendships, only: [:create]
  end

  get 'profile/:id', to: 'pages#user_profile', as: :user_profile
end
