Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  # as: でルートの置き換えができる
  get '/help', to:'static_pages#help' #as:'helf'
  get '/about', to:'static_pages#about'
  get '/contact', to:'static_pages#contact'

  get '/signup', to:'users#new'

  get '/index', to:'users#index'

  get '/account_activations/:id/edit', to:'account_activations#edit'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # URL(/users/1)を追加する
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
