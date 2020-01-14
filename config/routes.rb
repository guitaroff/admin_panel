Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/admin')

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :show, :create]
      resources :sessions, only: :create

      get   'account', to: 'account#show'
      patch 'account', to: 'account#update'
      patch 'account/avatar_upload', to: 'account#avatar_upload'
    end
  end
end
