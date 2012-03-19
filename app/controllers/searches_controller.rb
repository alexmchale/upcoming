class SearchesController < ApplicationController

  before_filter :filter_parameters, :if => lambda { params[:search] }

  def index
    @searches = Search.includes(:records).all
  end

  def show
    @search = Search.includes(:records).find params[:id]
  end

  def new
    @search = Search.new
  end

  def create
    @search = Search.new params[:search]
    @search.retailer = Retailer.find_by_name "iTunes"

    if @search.save
      session[:search_id] = @search.id
      redirect_to search_path @search
    else
      render "new"
    end
  end

  def save
    options = params[:search].unpack("m").first
    raise options.inspect
  end

  protected

  def filter_parameters
    params[:search].slice! :parameters
  end

end
