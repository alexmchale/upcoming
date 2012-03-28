module ApplicationHelper

  def active_if page
    return if page.blank?
    c, a = page.split "#"
    "active" if controller.controller_name == c && controller.action_name == a
  end

  def navbar_link text, target, active_page = nil, li_options = {}, a_options = {}, pjax = true
    li_options[:class] ||= ""
    li_options[:class] << " #{active_if active_page}"
    a_options["data-pjax"] = "#main-payload" if pjax

    content_tag :li, li_options do
      link_to text, target, a_options
    end
  end

  def navbar_search_results search_results
    if search_results.present?
      title = pluralize search_results.count, "New Matches"
      li_options = { id: "search-results-navbar" }
      a_options = { "id" => "search-results-link", "data-result-count" => search_results.count }

      navbar_link title, search_results_path, "search_results#index", li_options, a_options
    end
  end

end
