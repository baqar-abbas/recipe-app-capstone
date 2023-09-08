Rails.application.routes.draw do
  devise_for :users
 
  root "users#index"

  resources :users do
    resources :recipes do
      resources :recipe_foods, only: [:new, :create]
    end
    resources :foods, except: [:update] do
    end
  end
end
