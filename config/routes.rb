Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #

  root 'hp#index'

  namespace :api do
    namespace :v1 do
      get 'posts/index'
      post 'posts/create'
      patch 'posts/:id', to: 'posts#update'
      delete 'posts/:id', to: 'posts#destroy'
    end
  end
end
