Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :users, only: [] do
    resources :friendships, only: [:create]
  end

  resources :friendships, only: [:index]

  root to: 'pages#home'

  resources :groups do
    resources :group_members, only: [:new, :create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
