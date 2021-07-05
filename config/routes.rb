Rails.application.routes.draw do
  resources :urls
  get '/auth/login', to: 'auth#login'

  root to: 'auth#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
