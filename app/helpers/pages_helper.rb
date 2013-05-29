module PagesHelper
  def shadow_tag shadow_name
    image_tag "shadows/shadow_#{shadow_name}.png",
      class: "shadow-thumb",
      onclick: "window.maker.shape_changed('#{shadow_name}')",
      size: "140x140"
  end
end
