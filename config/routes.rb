Upcoming::Application.routes.draw do

  get "welcome", to: "welcome#index"

  devise_for :users

  resources :searches do
    member do 
      get :monitor_by_email
      get "delete", as: "destroy", to: "searches#destroy"
    end
  end

  root to: "welcome#index"

end
