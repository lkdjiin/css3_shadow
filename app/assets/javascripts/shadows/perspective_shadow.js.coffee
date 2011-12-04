################################################################################
# Representing the state of a Left Perspective Shadow.
################################################################################
class window.PerspectiveShadow extends window.BaseShadow

  # Create a new shadow.
  constructor: ->
    super()
    
    @left = 80
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
  
  
  # value - Integer.
  set_left: (value) ->
    @left = value
    jss '#box:before',
      left: value + 'px'
  
  # value - Integer.
  set_bottom: (value) ->
    @bottom = value
    jss '#box:before',
      bottom: value + 'px'
      
  # value - Integer.
  set_width: (value) ->
    @width = value
    jss '#box:before',
      width: value + '%'
  
  # value - Integer.
  set_height: (value) ->
    @height = value
    jss '#box:before',
      height: value + '%'
  
  # value - Integer.
  set_xshift: (value) ->
    @xshift = value
    jss '#box:before',
      boxShadow: @_color_for_before()
  
  # value - Integer.
  set_blur: (value) ->
    @blur = value
    jss '#box:before',
      boxShadow: @_color_for_before()
      
  # value - Integer.
  set_opacity: (value) ->
    @opacity = value / 100
    jss '#box:before',
      boxShadow: @_color_for_before()
  
  # value - Integer.
  set_skew: (value) ->
    @skew = value
    jss '#box:before',
      MozTransform: "skew(#{@skew}deg)"
  
  # value - Integer.
  set_yorigin: (value) ->
    @yorigin = value
    jss '#box:before',
      MozTransformOrigin: "#{@xorigin}% #{@yorigin}%"
      
  # value - Integer.
  set_radius: (value) ->
    @radius = value
    jss '#box:before',
      borderRadius: "#{value}% 0 0 0"
  
  # Set the UI (sliders, etc.) to tweak the shadow.
  _setup_shadow_part: ->
    (@setup_part_sublayer() +
    @setup_part("Left", "left", @left, 'px') +
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
    @set_slider_callback("left", 0, 100, @left)
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
    jss '#box:before',
      left: "#{@left}px"
      bottom: "#{@bottom}px"
      width: "#{@width}%"
      height: "#{@height}%"
      boxShadow: "-#{@xshift}px 0 #{@blur}px rgba(0,0,0,#{@opacity})"
      MozTransform: "skew(#{@skew}deg)"
      MozTransformOrigin: "#{@xorigin}% #{@yorigin}%"
      zIndex: -1
      borderRadius: "#{@radius}% 0 0 0"
  
  
  # The CSS 'box-shadow' value for 'box:before'.
  #
  # Returns String.
  # TODO this should be in parent
  _color_for_before: -> "-#{@xshift}px 0 #{@blur}px rgba(0,0,0,#{@opacity})"
  
  
  # Get the CSS code fot the '#box:before'.
  #
  # Returns String.
  code_for_box_before: ->
    "#box:before {\n
    position: absolute;\n
    left: #{@left}px;\n
    bottom: #{@bottom}px;\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    border-radius: #{@radius}% 0 0 0;\n
    z-index: -1;\n
    content: \"\";\n
    -webkit-box-shadow: #{@_color_for_before()};\n
    box-shadow: #{@_color_for_before()};\n
    -webkit-transform: skew(#{@skew}deg);\n
    -moz-transform: skew(#{@skew}deg);\n
    -ms-transform: skew(#{@skew}deg);\n
    -o-transform: skew(#{@skew}deg);\n
    transform: skew(#{@skew}deg);\n
    -webkit-transform-origin: #{@xorigin}% #{@yorigin}%;\n
    -moz-transform-origin: #{@xorigin}% #{@yorigin}%;\n
    -ms-transform-origin: #{@xorigin}% #{@yorigin}%;\n
    -o-transform-origin: #{@xorigin}% #{@yorigin}%;\n
    transform-origin: #{@xorigin}% #{@yorigin}%;\n
    }\n"
  
  # The CSS 'box-shadow' value for 'box:after'.
  #
  # Returns String.
  code_for_box_after: -> ""
