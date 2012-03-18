class SearchesController < ApplicationController

  def new
  end

  def create
    session[:last_search] = params[:search]

    @search = Search.new params[:search]
  end

end
