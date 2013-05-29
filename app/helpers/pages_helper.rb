module PagesHelper
  def shadow_types
    [
      [ "basic", "Basic" ],
      [ "curled", "Curled"],
      [ "curved_hz", "Curved horizontal" ],
      [ "curved_hz_bottom", "Curved horizontal (bottom only)" ],
      [ "curved_hz_top", "Curved horizontal (top only)" ],
      [ "perspective", "Left perspective" ],
      [ "perspective_r", "Right perspective" ],
      [ "curved_vt", "Curved vertical" ],
      [ "see_through_tape", "See through tape" ],
      [ "wrinkled", "Wrinkled" ]
    ]
  end

  def shadow_tag type
    image_tag("shadows/shadow_#{type}.png",
      onclick: "window.maker.shape_changed('#{type}')",
      size: "140x140")
  end
end
