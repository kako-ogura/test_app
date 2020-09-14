Rails.application.routes.draw do
  root 'static_pages#home'
  # as: でルートの置き換えができる
  get '/help', to:'static_pages#help' #as:'helf'
  get '/about', to:'static_pages#about'
  get '/contact', to:'static_pages#contact'

  get '/signup', to:'users#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # URL(/users/1)を追加する
  resources :users
end
