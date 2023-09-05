Rails.application.routes.draw do
  devise_for :users

  # devise_scope :users do 
  # end

  root "users#index"
  
  resources :users do
  end
end
