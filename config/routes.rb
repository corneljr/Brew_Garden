Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  resources :pledges
  resources :sessions, :only => [:new, :create, :destroy]
	resources :users
  root to: "welcome#index"

  resources :projects do
    resources :updates
  	resources :rewards, only: [:create, :destroy, :update, :show] do
  		resources :pledges, only: [:create, :show]
  	end
  end

  get 'projects/:project_id/backers', to: 'projects#backers', as: 'project_backers'
end
