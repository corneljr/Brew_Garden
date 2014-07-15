Rails.application.routes.draw do
  resources :pledges
  root to: "welcome#index"
end
