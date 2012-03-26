class WelcomeController < ApplicationController

  def index
    if current_user && request.referer.blank?
      redirect_to searches_path
    end
  end

end
