module ApplicationHelper

  def base_title
    "CSS3 Drop Shadows Generator"
  end

  def top_menu
    pages = {
      "home" => root_path,
      "app" => app_path,
      "comments" => comments_path,
      "about" => about_path
    }
    pages.map do |key, value|
      classnames = %( class="active") if controller.action_name == key
      "<li#{classnames}>#{link_to(key, value)}</li>"
    end.join.html_safe
  end
end
