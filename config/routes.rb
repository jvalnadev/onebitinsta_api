Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      concern :likeable do |options|
        shallow do
          post "/likes", { to: "likes#create", on: :member }.merge(options)
          delete "/unlikes", { to: "likes#destroy", on: :member }.merge(options)
        end
      end

      resources :home, only: :index
      resources :search, only: :index

      resources :users, only: :show do
        resources :posts, only: :index
        resources :followings, only: %i(index create destroy), shallow: true
      end

      resources :posts, only: %i(create show update destroy) do
        concerns :likeable, likeable_type: 'Post'
      end
    end
  end
end
