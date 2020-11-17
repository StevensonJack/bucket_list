Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :buckets do
    resources :activities do
      resources :offers, only: :show
    end
  end
  resources :activities, only: [ :destroy ]
end
