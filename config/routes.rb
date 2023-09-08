Rails.application.routes.draw do
  devise_for :users
 
  root "users#index"

  resources :users do
    resources :recipes do
      resources :recipe_foods, only: [:new, :create]
    end
    resources :public_recipes, only: [:index]
    resources :foods, except: [:update] do
    end
    resources :general_shopping_list, only: [:index]
  end
end
