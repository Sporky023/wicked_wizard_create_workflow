Rails.application.routes.draw do
  get 'soup_recipes/show'

  root to: 'visitors#index'
  devise_for :users
  resources :users

  resources :soup_recipes

  resources :soup_recipe_wizard
end
