Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show]
      post '/auth/login', to: 'authentication#login'
      post '/auth/signup', to: 'authentication#signup'
    end
  end
  match '*unmatched', to: 'application#not_found', via: :all
end
