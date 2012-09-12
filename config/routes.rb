Nbvoterapp::Application.routes.draw do
  root :to => "welcome#index"

  devise_for :users

  resources :persist_data
  resources :voters
  resources :oauth_consumers do
    member do
      get :callback
      get :callback2
      match 'client/*endpoint' => 'oauth_consumers#client'
    end
  end

end
