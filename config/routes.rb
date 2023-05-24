Rails.application.routes.draw do
  devise_for :users
  resources :inventories, only: [:index, :show, :new, :create, :destroy]
  resources :foods, only: [:new, :create, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :destroy]
  resources :users, only: [:index, :show]
  resources :public_recipe, only: [:index]
  resources :shopping_list, only: [:index]

  # resources :recipe_foods, only: [:new, :create, :destroy]
  # resources :users, only: [:index, :show] do
  #   resources :inventories, controller: 'users/inventories' do
  #     resources :foods, only: [:new, :create, :destroy], controller: 'users/inventories/foods'
  #     # resources :recipe_foods, only: [:create], controller: 'users/posts/likes'
  #   end
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "inventories#index"
end
