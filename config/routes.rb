Rails.application.routes.draw do
  root to: "welcome#index"

  resources :projects do
  	resources :rewards, only: [:create, :destroy, :update] 
  end
end
