Rails.application.routes.draw do
  # simple auth to get urls API access: 
  # assuming there is a created user, with email(see seeds.rb),
  # pass an email of existing user to get a jwt token
  get '/auth/login', to: 'auth#login'

  # not great urls api design, alhough it meets task requirements;
  # might be better to use simple hardcoded `get` route(depends on project conventions)
  resources :urls, except: :show do
    collection do
      get ':code', action: :show
    end
  end

  root to: 'auth#login'
end
