Rails.application.routes.draw do
  resources :pledges
  resources :users, :only => [:create, :show, :destroy]
  root to: "welcome#index"
end
