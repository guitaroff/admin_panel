Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/admin')

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: :create
    end
  end
end
