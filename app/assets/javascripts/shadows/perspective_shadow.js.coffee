################################################################################
# Representing the state of a Perspective Shadow.
################################################################################
class window.PerspectiveShadow extends window.BaseShadow

  # Create a new shadow.
  #
  # subtype - 'left' for left perspective
  #           'right' for right perspective
  constructor: (subtype) ->
    super()
    
    @subtype = subtype
    
    @left = 80 if subtype is 'left'
    @right = 80 if subtype is 'right'
    @bottom = 5
    @width = 100
    @height = 37
    @xshift = 86
    @blur = 17
    @opacity = 0.33
    @skew = 36
    @xorigin = 0
    @yorigin = 100
    @radius = 10
  
    @init()
    window.box_tweaking.set_default()
  
  
  # value - Integer.
  set_left: (value) ->
    @left = value
    window.sheet_mgr.set SSC.BEFORE, "left", "#{@left}px"
  
  # value - Integer.
  set_right: (value) ->
    @right = value
    window.sheet_mgr.set SSC.BEFORE, "right", "#{@right}px"
  
  # value - Integer.
  set_bottom: (value) ->
    @bottom = value
    window.sheet_mgr.set SSC.BEFORE, "bottom", "#{@bottom}px"
      
  # value - Integer.
  set_width: (value) ->
    @width = value
    window.sheet_mgr.set SSC.BEFORE, "width", "#{@width}%"
  
  # value - Integer.
  set_height: (value) ->
    @height = value
    window.sheet_mgr.set SSC.BEFORE, "height", "#{@height}%"
  
  # value - Integer.
  set_xshift: (value) ->
    @xshift = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
  
  # value - Integer.
  set_blur: (value) ->
    @blur = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
      
  # value - Integer.
  set_opacity: (value) ->
    @opacity = value / 100
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
  
  # value - Integer.
  set_skew: (value) ->
    @skew = value
    tmp = "skew(#{@skew}deg)"
    tmp = "skew(-#{@skew}deg)" if @subtype is 'right'
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM, tmp
  
  # value - Integer.
  set_yorigin: (value) ->
    @yorigin = value
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM_ORIGIN, "#{@xorigin}% #{@yorigin}%"
      
  # value - Integer.
  set_radius: (value) ->
    @radius = value
    tmp = "#{value}% 0 0 0"
    tmp = "0 #{value}% 0 0" if @subtype is 'right'
    window.sheet_mgr.set SSC.BEFORE, SSC.BORDER_RADIUS, tmp
  
  # Set the UI (sliders, etc.) to tweak the shadow.
  _setup_shadow_part: ->
    tmp = @setup_part("Left", "left", @left, 'px')
    tmp = @setup_part("Right", "right", @right, 'px') if @subtype is 'right'
    (@setup_part_sublayer() +
    tmp +
    @setup_part("Bottom", "bottom", @bottom, 'px') +
    @setup_part("Width", "width", @width) +
    @setup_part("Height", "height", @height) +
    @setup_part("Color X shift", "xshift", @xshift, 'px') +
    @setup_part("Color blur", "blur", @blur, 'px') +
    @setup_part("Color opacity", "opacity", @opacity) +
    @setup_part("Skew", "skew", @skew, 'deg') +
    @setup_part("Skew Y origin", "yorigin", @yorigin) +
    @setup_part("Radius", "radius", @radius))
    
  # Set callback methods (mostly on sliders) to know what to do when values
  # changed.
  _set_callbacks: ->
    if @subtype is 'left'
      @set_slider_callback("left", 0, 100, @left)
    else
      @set_slider_callback("right", 0, 100, @right)
    @set_slider_callback("bottom", 0, 100, @bottom)
    @set_slider_callback("width", 0, 100, @width)
    @set_slider_callback("height", 0, 100, @height)
    @set_slider_callback("xshift", 0, 200, @xshift)
    @set_slider_callback("blur", 0, 50, @blur)
    @set_slider_callback("opacity", 0, 100, @opacity * 100)
    @set_slider_callback("skew", 0, 90, @skew)
    @set_slider_callback("yorigin", 0, 100, @yorigin)
    @set_slider_callback("radius", 0, 50, @radius)
  
  # Display a shadow on the box with default values.
  _display_default_shadow: ->
    window.sheet_mgr.delete_rules()
    after = "z-index: -1;"
    before = "bottom: #{@bottom}px;
              width: #{@width}%;
              height: #{@height}%;
              #{SSC.CSS_TRANSFORM_ORIGIN}: #{@xorigin}% #{@yorigin}%;
              z-index: -1;"
      
    if @subtype is 'left'
      before += "left: #{@left}px;
                 #{SSC.CSS_BOX_SHADOW}: -#{@xshift}px 0 #{@blur}px rgba(0,0,0,#{@opacity});
                 #{SSC.CSS_TRANSFORM}: skew(#{@skew}deg);
                 #{SSC.CSS_BORDER_RADIUS}: #{@radius}% 0 0 0;"
    else
      before += "right: #{@right}px;
                 #{SSC.CSS_BOX_SHADOW}: #{@xshift}px 0 #{@blur}px rgba(0,0,0,#{@opacity});
                 #{SSC.CSS_TRANSFORM}: skew(-#{@skew}deg);
                 #{SSC.CSS_BORDER_RADIUS}: 0 #{@radius}% 0 0;"
    window.sheet_mgr.insert_after_and_before_rules after, before


  # The CSS 'box-shadow' value for 'box:before'.
  #
  # Returns String.
  # TODO this should be in parent
  _color_for_before: ->
    if @subtype is 'left'
      "-#{@xshift}px 0 #{@blur}px rgba(0,0,0,#{@opacity})"
    else
      "#{@xshift}px 0 #{@blur}px rgba(0,0,0,#{@opacity})"


  # Get the CSS code fot the '#box:before'.
  #
  # Returns String.
  code_for_box_before: ->
    if @subtype is 'left'
      ".box:before {\n
      position: absolute;\n
      left: #{@left}px;\n
      bottom: #{@bottom}px;\n
      width: #{@width}%;\n
      height: #{@height}%;\n
      border-radius: #{@radius}% 0 0 0;\n
      z-index: -1;\n
      content: \"\";\n
      box-shadow: #{@_color_for_before()};\n
      #{@css_code_for_transform('skew(' + @skew + 'deg)')}
      #{@css_code_for_transform_origin(@xorigin + '% ' + @yorigin + '%')}
      }\n"
    else
      ".box:before {\n
      position: absolute;\n
      right: #{@right}px;\n
      bottom: #{@bottom}px;\n
      width: #{@width}%;\n
      height: #{@height}%;\n
      border-radius: 0 #{@radius}% 0 0;\n
      z-index: -1;\n
      content: \"\";\n
      box-shadow: #{@_color_for_before()};\n
      #{@css_code_for_transform('skew(-' + @skew + 'deg)')}
      #{@css_code_for_transform_origin(@xorigin + '% ' + @yorigin + '%')}
      }\n"

  # Get the SASS code fot the '#box:before'.
  #
  # Returns String.
  sass_for_box_before: ->
    if @subtype is 'left'
      ".box:before\n
  position: absolute\n
  left: #{@left}px\n
  bottom: #{@bottom}px\n
  width: #{@width}%\n
  height: #{@height}%\n
  border-radius: #{@radius}% 0 0 0\n
  z-index: -1\n
  content: \"\"\n
  box-shadow: #{@_color_for_before()}\n
  #{@sass_code_for_transform('skew(' + @skew + 'deg)')}
  #{@sass_code_for_transform_origin(@xorigin + '% ' + @yorigin + '%')}\n"
    else
      ".box:before\n
  position: absolute\n
  right: #{@right}px\n
  bottom: #{@bottom}px\n
  width: #{@width}%\n
  height: #{@height}%\n
  border-radius: 0 #{@radius}% 0 0\n
  z-index: -1\n
  content: \"\"\n
  box-shadow: #{@_color_for_before()}\n
  #{@sass_code_for_transform('skew(-' + @skew + 'deg)')}
  #{@sass_code_for_transform_origin(@xorigin + '% ' + @yorigin + '%')}\n"

  # The CSS 'box-shadow' value for 'box:after'.
  #
  # Returns String.
  code_for_box_after: -> ""

  # The SASS 'box-shadow' value for 'box:after'.
  #
  # Returns String.
  sass_for_box_after: -> ""
