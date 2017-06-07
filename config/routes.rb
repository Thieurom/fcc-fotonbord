Rails.application.routes.draw do
  root 'home#index'
  get '/auth/twitter', as: :twitter_login
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#auth_failure'
  get '@:nickname', to: 'users#show', as: :user
  delete '/logout', to: 'sessions#destroy'
end
