module SearchHelper

  def active_media_class id
    last_media = session[:last_search][:media] if session[:last_search]
    last_media ||= "all"

    if last_media == id then "active" else "" end
  end

  def search_tab_for id, text
    content_tag :li, :class => active_media_class(id) do
      content_tag :a, "data-toggle" => "tab", "href" => "##{id}" do
        text
      end
    end
  end

  def search_pane_for id, &b
    content_tag :div, :class => "tab-pane #{active_media_class id}", :id => id do
      form_tag search_path do
        raw [
          hidden_field_tag("search[media]", id),
          content_tag(:div, &b)
        ].join
      end
    end
  end

end
