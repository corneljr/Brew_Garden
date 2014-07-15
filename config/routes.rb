Rails.application.routes.draw do
  get 'pledges/create'

  get 'pledges/destroy'

  get 'pledges/update'

  root to: "welcome#index"
end
