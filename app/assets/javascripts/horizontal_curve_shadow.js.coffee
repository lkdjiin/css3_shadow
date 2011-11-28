################################################################################
# Representing the state of an Horizontal Curved Shadow.
################################################################################
class window.HorizontalCurveShadow extends window.BaseShadow

  constructor: ->
    super()
    @width = 80
    @height = 20
    @radius = 50
    @left = 10
    @distance = 0
    @blur = 10
    @shift = 15
    @opacity = 0.5
    
    # Set the UI
    $("#setup_shadow").html(@_setup_shadow_part())
    
    @_set_callbacks()
    @_display_default_shadow()
  
  
  # value - Integer.
  set_width: (value) ->
    @width = value
    @left = (100 - value) / 2
    jss '#box:before',
      width: value + '%'
      left: "#{@left}%"
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
  set_shift: (value) ->
    @shift = value
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
    code += @code_for_box_before()
    code += @code_for_box_after()
  
  
  # private
  
  _setup_shadow_part: ->
    (@setup_part_sublayer() +
    @setup_part("Width", "width", 80) +
    @setup_part("Height", "height", 20) +
    @setup_part("Radius", "radius", 50) +
    @setup_part("Distance", "distance", 0) +
    @setup_part("Color blur", "blur", 10) +
    @setup_part("Color shift", "shift", 15) +
    @setup_part("Color opacity", "opacity", 0.5) )
  
  
  _set_callbacks: ->
    @set_slider_callback("width", 50, 100, 80, 2)
    @set_slider_callback("height", 5, 50, 20)
    @set_slider_callback("radius", 0, 50, 50)
    @set_slider_callback("distance", 0, 10, 0)
    @set_slider_callback("blur", 0, 50, 10)
    @set_slider_callback("shift", 0, 50, 15)
    @set_slider_callback("opacity", 0, 100, 50)


  _display_default_shadow: ->
    jss '#box:before',
      boxShadow: "0 -#{@shift}px #{@blur}px rgba(0,0,0,#{@opacity})"
      borderRadius: "#{@radius}%"
      left: "#{@left}%"
      top: 0
      zIndex: -1
      width: "#{@width}%"
      height: "#{@height}%"
    jss '#box:after',
      boxShadow: "0 #{@shift}px #{@blur}px rgba(0,0,0,#{@opacity})"
      borderRadius: "#{@radius}%"
      left: "#{@left}%"
      bottom: 0
      zIndex: -1
      width: "#{@width}%"
      height: "#{@height}%"
      
      
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
    -webkit-box-shadow: 0 -#{@shift}px #{@blur}px rgba(0,0,0,#{@opacity});\n
    box-shadow: 0 -#{@shift}px #{@blur}px rgba(0,0,0,#{@opacity});\n
    }\n"


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
    -webkit-box-shadow: 0 #{@shift}px #{@blur}px rgba(0,0,0,#{@opacity});\n
    box-shadow: 0 #{@shift}px #{@blur}px rgba(0,0,0,#{@opacity});\n
    }\n"


  _color_for_before: ->
    "0 -#{@shift}px #{@blur}px rgba(0,0,0,#{@opacity})"
  
  
  _color_for_after: ->
    "0 #{@shift}px #{@blur}px rgba(0,0,0,#{@opacity})"
