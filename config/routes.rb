Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # for sidekiq admin panel
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  #user routes
  get 'users/:id', to: "users#show", as: "my_profile"
  resources :users, only: [ :show, :edit, :update, :destroy ] do
    member do
      get :my_buckets
    end
  end

  #buckets routes
  resources :buckets, :path => "my_buckets" do
    resources :activities do
      resources :offers, only: :show
    end
  end
  #activities routes
  resources :activities, only: [ :destroy ]
end
