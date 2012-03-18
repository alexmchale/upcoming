Upcoming::Application.routes.draw do

  devise_for :users

  resource :search do
    get :save
  end

  root to: "searches#new"

end
