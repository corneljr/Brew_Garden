Rails.application.routes.draw do
  resources :users, :only => [:create, :show, :destroy]
  root to: "welcome#index"
end
