################################################################################
# Representing the state of an Horizontal Curved Shadow.
################################################################################
class window.HorizontalCurveShadow extends window.BaseShadow

  # Create a new shadow with horizontal curves.
  #
  # subtype - 'top' for top only shadow
  #           'bottom' for bottom only shadow
  #           'both' for top and bottom shadows
  constructor: (subtype)->
    super()
    
    @top_shadow = if subtype in ['top', 'both'] then true else false
    @bottom_shadow = if subtype in ['bottom', 'both'] then true else false
    
    @width = 80
    @height = 40
    @radius = 50
    @left = 10
    @distance = 0
    @blur = 16
    @yshift = 7
    @opacity = 0.4
    
    @init()
  
  
  # value - Integer.
  set_width: (value) ->
    @width = value
    @left = (100 - value) / 2
    if @top_shadow
      window.sheet_mgr.set SSC.BEFORE, "width", "#{value}%"
      window.sheet_mgr.set SSC.BEFORE, "left", "#{@left}%"
    if @bottom_shadow
      window.sheet_mgr.set SSC.AFTER, "width", "#{value}%"
      window.sheet_mgr.set SSC.AFTER, "left", "#{@left}%"
      
      
  # value - Integer.
  set_height: (value) ->
    @height = value
    window.sheet_mgr.set_after_and_before "height", "#{value}%"
  
  
  # value - Integer.
  set_radius: (value) ->
    @radius = value
    window.sheet_mgr.set_after_and_before SSC.BORDER_RADIUS, "#{value}%"
  
  
  # value - Integer.
  set_distance: (value) ->
    @distance = value
    window.sheet_mgr.set SSC.BEFORE, "top", "#{value}%"
    window.sheet_mgr.set SSC.AFTER, "bottom", "#{value}%"
  
  
  # value - Integer.
  set_blur: (value) ->
    @blur = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.BOX_SHADOW, @_color_for_after()
  
  
  # value - Integer.
  set_yshift: (value) ->
    @yshift = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.BOX_SHADOW, @_color_for_after()
  
  
  # value - Integer.
  set_opacity: (value) ->
    @opacity = value / 100
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.BOX_SHADOW, @_color_for_after()
    
  
  # Set the UI (sliders, etc.) to tweak the shadow.
  _setup_shadow_part: ->
    (@setup_part_sublayer() +
    @setup_part("Width", "width", @width) +
    @setup_part("Height", "height", @height) +
    @setup_part("Radius", "radius", @radius) +
    @setup_part("Distance", "distance", @distance) +
    @setup_part("Color blur", "blur", @blur) +
    @setup_part("Color Y shift", "yshift", @yshift) +
    @setup_part("Color opacity", "opacity", @opacity) )
  
  
  # Set callback methods (mostly on sliders) to know what to do when values
  # changed.
  _set_callbacks: ->
    @set_slider_callback("width", 50, 100, @width, 2)
    @set_slider_callback("height", 5, 50, @height)
    @set_slider_callback("radius", 0, 50, @radius)
    @set_slider_callback("distance", 0, 10, @distance)
    @set_slider_callback("blur", 0, 50, @blur)
    @set_slider_callback("yshift", 0, 50, @yshift)
    @set_slider_callback("opacity", 0, 100, @opacity * 100)

  # Display a shadow on the box with default values.
  _display_default_shadow: ->
    window.sheet_mgr.delete_rules()
    after = "z-index: -1;"
    before ="z-index: -1;"
    if @bottom_shadow
      after = "#{SSC.CSS_BOX_SHADOW}: 0 #{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity});
               #{SSC.CSS_BORDER_RADIUS}: #{@radius}%;
               z-index: -1;
               left: #{@left}%;
               bottom: 0;
               width: #{@width}%;
               height: #{@height}%;"
    if @top_shadow
      before = "#{SSC.CSS_BOX_SHADOW}: 0 -#{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity});
               #{SSC.CSS_BORDER_RADIUS}: #{@radius}%;
               z-index: -1;
               left: #{@left}%;
               top: 0;
               width: #{@width}%;
               height: #{@height}%;"
    window.sheet_mgr.insert_after_and_before_rules after, before
      
  # Get the CSS code fot the '#box:before'.
  #
  # Returns String.
  code_for_box_before: ->
    if @top_shadow
      "#box:before {\n
      position: absolute;\n
      width: #{@width}%;\n
      height: #{@height}%;\n
      left: #{@left}%;\n
      border-radius: #{@radius}%;\n
      z-index: -1;\n
      top: #{@distance}%;\n
      content: \"\";\n
      box-shadow: 0 -#{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity});\n
      }\n"
    else
      ""


  # Get the CSS code fot the '#box:after'.
  #
  # Returns String.
  code_for_box_after: ->
    if @bottom_shadow
      "#box:after {\n
      position: absolute;\n
      width: #{@width}%;\n
      height: #{@height}%;\n
      left: #{@left}%;\n
      border-radius: #{@radius}%;\n
      z-index: -1;\n
      bottom: #{@distance}%;\n
      content: \"\";\n
      box-shadow: 0 #{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity});\n
      }\n"
    else
      ""

  # The CSS 'box-shadow' value for 'box:before'.
  #
  # Returns String.
  _color_for_before: -> "0 -#{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"
    
  # The CSS 'box-shadow' value for 'box:after'.
  #
  # Returns String.
  _color_for_after: -> "0 #{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"
    
