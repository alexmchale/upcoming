module SearchHelper

  def active_media_class id
    last_media = session[:last_search][:media] if session[:last_search]
    last_media ||= "tvShow"

    if last_media == id then "active" else "" end
  end

  def search_tab_for id, text
    content_tag :li, :class => active_media_class(id) do
      content_tag :a, "data-toggle" => "tab", "href" => "##{id}" do
        text
      end
    end
  end

  def search_form_for search, id, &b
    content_tag :div, :class => "tab-pane #{active_media_class id}", :id => id do
      simple_form_for search do |f|
        b1 = lambda { b.call f }
        raw [
          hidden_field_tag("search[parameters][media]", id),
          content_tag(:div, &b1)
        ].join
      end
    end
  end

  def describe_search search
    search.parameters.inspect
  end

end
