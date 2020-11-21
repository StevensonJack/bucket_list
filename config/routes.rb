Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # User profile page
  get 'users/show', to: "user#show", as: "my_profile"

  resources :buckets do
    resources :activities do
      resources :offers, only: :show
    end
  end
  resources :activities, only: [ :destroy ]
end
