Rails.application.routes.draw do
  get 'holidays/index'
  get 'holidays/show'
  get 'holidays/new'
  get 'holidays/create'
  get 'holidays/edit'
  get 'holidays/update'
  get 'holidays/destroy'
  get 'events/index'
  get 'events/show'
  get 'events/new'
  get 'events/create'
  get 'events/edit'
  get 'events/update'
  get 'events/destroy'

  root "users#welcome"

  get '/employee', to: 'users#employee'
  get '/hr', to: 'users#hr'

  post '/login', to: 'application#login'
  delete '/logout' ,to:'application#logout'

  resources :users


end
