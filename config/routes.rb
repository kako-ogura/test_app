Rails.application.routes.draw do
  get '/signup', to:'users#new'
  root 'static_pages#home'
  get 'static_pages/home'
  # as: でルートの置き換えができる
  get '/help', to:'static_pages#help' #as:'helf'
  get '/about', to:'static_pages#about'
  get '/contact', to:'static_pages#contact'
  # URL(/users/1)を追加する
  resources :users
end
