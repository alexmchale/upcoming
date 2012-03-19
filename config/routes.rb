Upcoming::Application.routes.draw do

  devise_for :users

  resources :searches do
    get :save
  end

  root to: "searches#new"

end
