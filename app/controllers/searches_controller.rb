class SearchesController < ApplicationController

  #accepts fields: { search: [ :monitor_by_email, { parameters: %w( parameters monitor_by_email ) }

  before_filter :find_search, only: %w( show destroy monitor_by_email )

  def index
    @searches = current_or_guest_user.searches.includes(:records, :search_results).all

    if current_or_guest_user.searches.monitored.count == 0 && @searches.count > 0 && !email_instructed?
      flash.now[:alert] = "Click on an envelope and Upcoming will send you an email when that search finds new results."
    end
  end

  def show
    if current_or_guest_user.searches.monitored.count == 0 && !email_instructed?
      flash.now[:alert] = "Click on the envelope and Upcoming will send you an email when this search finds new results."
    end
  end

  def new
    @search = Search.new
    @search.style = current_or_guest_user.most_recent_search_style
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
    if current_user
      @search.monitor_by_email = !@search.monitor_by_email
      @search.save!
    end

    if request.xhr?
      render json: { success: true }
    else
      redirect_to request.referer
    end
  end

  def toggle_all_emails
    if current_user
      monitor_by_email = !current_user.searches.all?(&:monitor_by_email)
      current_user.searches.update_all monitor_by_email: monitor_by_email
      redirect_to searches_path
    else
      redirect_to sign_in_path
    end
  end

  def stop_all_emails
    if current_user
      current_user.searches.monitored.update_all monitor_by_email: false
      redirect_to searches_path
    else
      redirect_to sign_in_path
    end
  end

  protected

  def find_search
    @search = current_or_guest_user.searches.includes(:records).find params[:id]
  end

  def email_instructed?
    session[:email_instructed].tap { session[:email_instructed] = true }
  end

end
