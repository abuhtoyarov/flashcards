Rails.application.routes.draw do
  filter :locale

  root 'main#index'

  scope module: 'home' do
    resources :user_sessions, :users, only: [:new, :create]

    get 'login' => 'user_sessions#new', as: :login

    match 'oauth/callback' => 'oauths#callback', via: [:get, :post]
    get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  end

  scope module: 'dashboard' do
    resources :user_sessions, only: :destroy
    resources :users, only: :destroy
    post 'logout' => 'user_sessions#destroy', as: :logout

    resources :cards

    resources :blocks do
      member do
        put 'set_as_current'
        put 'reset_as_current'
      end
    end

    put 'review_card' => 'trainers#review_card'
    get 'trainer' => 'trainers#index'

    resources :profiles, only: [:edit, :update]
  end
end
