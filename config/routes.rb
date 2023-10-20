# frozen_string_literal: true

Rails.application.routes.draw do
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  devise_for :users,
             controllers: {
               registrations: 'users/registrations'
             }

  get '/home', to: 'users#home', as: :home
  post '/create_employee', to: 'users#create'
  delete '/logout', to: 'application#logout'

  get 'approve/:id', to: 'leave_requests#approve_request', as: :approve
  get 'reject/:id', to: 'leave_requests#reject_request', as: :reject

  get 'status', action: :status, controller: 'users' # , to: 'users#status'
  get 'history', to: 'leave_requests#history'
  get 'all_leave_request', to: 'leave_requests#index'

  resources :users
  resources :events
  resources :holidays
  resource :leave_request
end
