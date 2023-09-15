# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'users#home'

  post '/create_employee', to: 'users#create'
  delete '/logout', to: 'application#logout'

  get 'approve/:id', to: 'leave_requests#approve_request'
  get 'reject/:id', to: 'leave_requests#reject_request'

  get 'status', to: 'users#status'
  get 'history', to: 'leave_requests#history'
  get 'all_leave_request', to: 'leave_requests#index'

  resources :users
  resources :events
  resources :holidays
  resource :leave_request
end
