Rails.application.routes.draw do
  devise_for :users
 
  root "users#index"

  resources :users do
    resources :recipes, except: [:update] do
    end
    resources :foods, except: [:update] do
    end
  end
end
