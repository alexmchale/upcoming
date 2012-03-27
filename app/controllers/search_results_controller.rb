class SearchResultsController < ApplicationController

  def index
    if @unacknowledged_search_results.blank?
      redirect_to searches_path
    end
  end

  def acknowledge
    results = current_or_guest_user.search_results
    results = results.where(id: params[:id]) if params[:id].present?
    results.update_all acknowledged: true

    redirect_to request.referer || root_path
  end

end
