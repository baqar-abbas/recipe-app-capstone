Rails.application.routes.draw do
  devise_for :users
 
  root "users#index"

  resources :users do
    resources :recipes do
      resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
      resources :shopping_list, only: [:index], on: :member
    end
    # resources :shopping_list, only: [:index]
    resources :public_recipes, only: [:index]
    resources :foods, except: [:update]
    resources :general_shopping_list, only: [:index]
  end
end
