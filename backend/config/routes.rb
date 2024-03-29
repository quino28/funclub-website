Rails.application.routes.draw do
  # Admin routes
  get '/', to: 'admin#initial_page'
  get '/admin', to: 'admin#initial_page'
  namespace :admin do
    get '/login', to: 'login#index'
    post '/login', to: 'login#login'
    delete '/logout', to: 'login#logout'
    resources :admin_members, only: [:index, :new, :create, :show, :edit, :update, :delete, :destroy]
    resources :members, only: [:index, :new, :create, :show, :edit, :update, :delete, :destroy]
  end

  # Api routes
  namespace :api do
    post '/sign_in', to: 'sign_in#sign_in'
    post '/sign_up', to: 'sign_up#sign_up'
    post '/member/update', to: 'member#update'
  end

  # Not found pages
  get '/*not_found', to: 'routes#routing_error'
  post '/*not_found', to: 'routes#routing_error'
end
