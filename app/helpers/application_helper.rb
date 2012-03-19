module ApplicationHelper

  def active_if page
    c, a = page.split "#"
    "active" if controller.controller_name == c && controller.action_name == a
  end

end
