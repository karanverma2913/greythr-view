Rails.application.routes.draw do
  root "users#welcome"

  get '/home', to: 'users#home'
  post '/login', to: 'application#login'
  delete '/logout' ,to:'application#logout'

  resources :users
  resources :events
  resources :holidays
  resource :leave_request

end
