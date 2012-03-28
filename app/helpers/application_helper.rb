module ApplicationHelper

  def active_if page
    c, a = page.split "#"
    "active" if controller.controller_name == c && controller.action_name == a
  end

  def navbar_search_results search_results
    if search_results.present?
      content_tag :li, class: active_if("search_results#index"), id: "search-results-navbar" do
        title = pluralize search_results.count, "New Matches"
        options = { "id" => "search-results-link", "data-result-count" => search_results.count }
        link_to title, search_results_path, options
      end
    end
  end

end
