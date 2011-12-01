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
    
    @set_the_UI()
    @_set_callbacks()
    @_display_default_shadow()
  
  
  # value - Integer.
  set_width: (value) ->
    @width = value
    @left = (100 - value) / 2
    if @top_shadow
      jss '#box:before',
        width: value + '%'
        left: "#{@left}%"
    if @bottom_shadow
      jss '#box:after',
        width: value + '%'
        left: "#{@left}%"
      
      
  # value - Integer.
  set_height: (value) ->
    @height = value
    jss '#box:before',
      height: value + '%'
    jss '#box:after',
      height: value + '%'
  
  
  # value - Integer.
  set_radius: (value) ->
    @radius = value
    jss '#box:before',
      borderRadius: value + '%'
    jss '#box:after',
      borderRadius: value + '%'
  
  
  # value - Integer.
  set_distance: (value) ->
    @distance = value
    jss '#box:before',
      top: value + '%'
    jss '#box:after',
      bottom: value + '%'
  
  
  # value - Integer.
  set_blur: (value) ->
    @blur = value
    jss '#box:before',
      boxShadow: @_color_for_before()
    jss '#box:after',
      boxShadow: @_color_for_after()
  
  
  # value - Integer.
  set_yshift: (value) ->
    @yshift = value
    jss '#box:before',
      boxShadow: @_color_for_before()
    jss '#box:after',
      boxShadow: @_color_for_after()
  
  
  # value - Integer.
  set_opacity: (value) ->
    @opacity = value / 100
    jss '#box:before',
      boxShadow: @_color_for_before()
    jss '#box:after',
      boxShadow: @_color_for_after()
    
    
  # Get the CSS3 code for this particular shadow effect.
  #
  # Returns String.
  to_string: ->
    code = @code_for_box()
    code += @code_for_box_before() if @top_shadow
    code += @code_for_box_after() if @bottom_shadow
    code
  
  # private
  
  
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
  
  
  _set_callbacks: ->
    @set_slider_callback("width", 50, 100, @width, 2)
    @set_slider_callback("height", 5, 50, @height)
    @set_slider_callback("radius", 0, 50, @radius)
    @set_slider_callback("distance", 0, 10, @distance)
    @set_slider_callback("blur", 0, 50, @blur)
    @set_slider_callback("yshift", 0, 50, @yshift)
    @set_slider_callback("opacity", 0, 100, @opacity * 100)


  _display_default_shadow: ->
    if @top_shadow
      jss '#box:before',
        boxShadow: "0 -#{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"
        borderRadius: "#{@radius}%"
        left: "#{@left}%"
        top: 0
        zIndex: -1
        width: "#{@width}%"
        height: "#{@height}%"
    if @bottom_shadow
      jss '#box:after',
        boxShadow: "0 #{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"
        borderRadius: "#{@radius}%"
        left: "#{@left}%"
        bottom: 0
        zIndex: -1
        width: "#{@width}%"
        height: "#{@height}%"
      
  
  # Get the CSS code fot the '#box:before'.
  #
  # Returns String.
  code_for_box_before: ->
    "#box:before {\n
    position: absolute;\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    left: #{@left}%;\n
    border-radius: #{@radius}%;\n
    z-index: -1;\n
    top: #{@distance}%;\n
    content: \"\";\n
    -webkit-box-shadow: 0 -#{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity});\n
    box-shadow: 0 -#{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity});\n
    }\n"


  # Get the CSS code fot the '#box:after'.
  #
  # Returns String.
  code_for_box_after: ->
    "#box:after {\n
    position: absolute;\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    left: #{@left}%;\n
    border-radius: #{@radius}%;\n
    z-index: -1;\n
    bottom: #{@distance}%;\n
    content: \"\";\n
    -webkit-box-shadow: 0 #{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity});\n
    box-shadow: 0 #{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity});\n
    }\n"


  _color_for_before: -> "0 -#{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"
    
  
  _color_for_after: -> "0 #{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"
    
