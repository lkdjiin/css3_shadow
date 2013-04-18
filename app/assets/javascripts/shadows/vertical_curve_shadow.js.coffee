################################################################################
# Representing the state of a Vertical Curved Shadow.
################################################################################
class window.VerticalCurveShadow extends window.BaseShadow

  # Create a new shadow with two vertical curves, left and right.
  constructor: ->
    super()
    
    @top = 10
    @bottom = 10
    @height = 80
    @blur = 15
    @opacity = 0.6
    @shift = 0
    @width = 100
    @left = 0
    @right = 0

    @init()
    window.box_tweaking.set_default()


  # value - Integer.
  set_height: (value) ->
    @top = @bottom = (100 - value) / 2
    @height = value
    window.sheet_mgr.set SSC.BEFORE, "top", "#{@top}%"
    window.sheet_mgr.set SSC.BEFORE, "bottom", "#{@bottom}%"
    window.sheet_mgr.set SSC.BEFORE, "height", "#{@height}%"
  
  
  # value - Integer.
  set_blur: (value) ->
    @blur = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
  
  
  # value - Integer.
  set_opacity: (value) ->
    @opacity = value / 100
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
  
  
  # Set the UI (sliders, etc.) to tweak the shadow.
  _setup_shadow_part: ->
    (@setup_part_sublayer() +
    @setup_part("Height", "height", 80) +
    @setup_part("Color blur", "blur", 10) +
    @setup_part("Color opacity", "opacity", 0.6) )
  
  # Set callback methods (mostly on sliders) to know what to do when values
  # changed.
  _set_callbacks: ->
    @set_slider_callback("height", 0, 100, 80, 2)
    @set_slider_callback("blur", 0, 50, 15)
    @set_slider_callback("opacity", 0, 100, 60)
  
  # Display a shadow on the box with default values.
  _display_default_shadow: ->
    window.sheet_mgr.delete_rules()
    after = "z-index: -1;"
    before = "#{SSC.CSS_BOX_SHADOW}: 0 0 #{@blur}px rgba(0,0,0,#{@opacity});
             #{SSC.CSS_BORDER_RADIUS}: 10px / 100px;
             z-index: -1;
             left: 0;
             right: 0;
             top: #{@top}%;
             bottom: #{@bottom}%;
             width: 100%;
             height: #{@height}%;"
    window.sheet_mgr.insert_after_and_before_rules after, before


  # Get the CSS code fot the '#box:before'.
  #
  # Returns String.
  code_for_box_before: ->
    ".box:before {\n
    position: absolute;\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    border-radius: 10px / 100px;\n
    z-index: -1;\n
    top: #{@top}%;\n
    bottom: #{@bottom}%;\n
    content: \"\";\n
    box-shadow: #{@_color_for_before()};\n
    }\n"

  # Get the SASS code fot the '#box:before'.
  #
  # Returns String.
  sass_for_box_before: ->
    ".box:before\n
  position: absolute\n
  width: #{@width}%\n
  height: #{@height}%\n
  border-radius: 10px / 100px\n
  z-index: -1\n
  top: #{@top}%\n
  bottom: #{@bottom}%\n
  content: \"\"\n
  box-shadow: #{@_color_for_before()}\n"

  # The CSS 'box-shadow' value for 'box:after'.
  #
  # Returns String.
  code_for_box_after: -> ""

  # The SASS 'box-shadow' value for 'box:after'.
  #
  # Returns String.
  sass_for_box_after: -> ""

  # The CSS 'box-shadow' value for 'box:before'.
  #
  # Returns String.
  _color_for_before: -> "0 0 #{@blur}px rgba(0,0,0,#{@opacity})"
    
  
     
