class SearchesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :filter_parameters, if: lambda { params[:search] }
  before_filter :find_search, only: %w( show destroy monitor_by_email )

  def index
    @searches = current_or_guest_user.searches.includes(:records).all
  end

  def show
  end

  def new
    @search = Search.new
  end

  def create
    @search = Search.new params[:search]
    @search.user = current_or_guest_user
    @search.retailer = Retailer.find_by_name "iTunes"

    if @search.save
      session[:search_id] = @search.id
      redirect_to search_path @search
    else
      render "new"
    end
  end

  def destroy
    term = @search.term
    @search.destroy

    flash[:notice] = "Your search for '#{term}' has been removed."
    redirect_to searches_path
  end

  def monitor_by_email
    @search.monitor_by_email = !@search.monitor_by_email
    @search.save!
    redirect_to request.referer
  end

  protected

  def filter_parameters
    params[:search].slice! :parameters
  end

  def find_search
    @search = current_or_guest_user.searches.includes(:records).find params[:id]
  end

end
