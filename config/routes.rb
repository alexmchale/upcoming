Upcoming::Application.routes.draw do

  get "welcome", to: "welcome#index"

  resources :searches do
    member do 
      get :monitor_by_email
      get "delete", as: "destroy", to: "searches#destroy"
    end
    collection do
      get :toggle_all_emails
      get :stop_all_emails
    end
  end

  resources :users

  resources :user_sessions
  get "/sign_in", as: "sign_in", to: "user_sessions#new"
  post "/sign_in", to: "user_sessions#create"
  get "/sign_out", as: "sign_out", to: "user_sessions#destroy"
  delete "/sign_out", as: "sign_out", to: "user_sessions#destroy"

  root to: "welcome#index"

end
