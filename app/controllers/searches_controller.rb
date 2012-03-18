class SearchesController < ApplicationController

  def new
  end

  def create
    @search = Search.new params[:search]
  end

end
