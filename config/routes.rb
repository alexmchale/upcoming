Upcoming::Application.routes.draw do

  resource :search

  root to: "search#new"

end
