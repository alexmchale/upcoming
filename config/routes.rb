Upcoming::Application.routes.draw do

  devise_for :users

  resources :searches do
    member do 
      get :monitor_by_email
    end
  end

  root to: "searches#new"

end
