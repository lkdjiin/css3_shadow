################################################################################
# Representing the state of an Vertical Curved Shadow.
################################################################################
class window.VerticalCurveShadow extends window.BaseShadow

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

    # Set the UI
    $("#setup_shadow").html(@_setup_shadow_part())
    
    @_set_callbacks()
    @_display_default_shadow()


  set_height: (value) ->
    @top = @bottom = (100 - value) / 2
    @height = value
    jss '#box:before',
      top: "#{@top}%"
      bottom: "#{@bottom}%"
      height: "#{@height}%"
  
  
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
    @setup_part("Height", "height", 80) +
    @setup_part("Color blur", "blur", 10) +
    @setup_part("Color opacity", "opacity", 0.6) )
  
  
  _set_callbacks: ->
    @set_slider_callback("height", 0, 100, 80, 2)
    @set_slider_callback("blur", 0, 50, 15)
    @set_slider_callback("opacity", 0, 100, 60)
  
  
  _display_default_shadow: ->
    jss '#box:before',
      boxShadow: "0 0 #{@blur}px rgba(0,0,0,#{@opacity})"
      borderRadius: "10px / 100px"
      left: 0
      right: 0
      top: "#{@top}%"
      bottom: "#{@bottom}%"
      zIndex: -1
      width: "100%"
      height: "#{@height}%"
  
  
  code_for_box_before: ->
    "#box:before {\n
    position: absolute;\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    border-radius: 10px / 100px;\n
    z-index: -1;\n
    top: #{@top}%;\n
    bottom: #{@bottom}%;\n
    content: \"\";\n
    -webkit-box-shadow: #{@_color_for_before()};\n
    box-shadow: #{@_color_for_before()};\n
    }\n"
  
  
  code_for_box_after: -> ""
  
  
  _color_for_before: -> "0 0 #{@blur}px rgba(0,0,0,#{@opacity})"
    
  
     
