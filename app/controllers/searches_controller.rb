class SearchesController < ApplicationController

  def show
    if session[:last_search]
      @search = Search.new session[:last_search]

      if @search.count == 0
        redirect_to new_search_path, notice: "I'm sorry, no results matched your search query."
      end
    else
      redirect_to new_search_path
    end
  end

  def new
  end

  def create
    session[:last_search] = params[:search]
    redirect_to search_path
  end

end
