################################################################################
# Representing the state of an Horizontal Curved Shadow.
################################################################################
class window.HorizontalCurveShadow extends window.BaseShadow

  constructor: ->
    super()
    
    # Members
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
    
    # Set callbacks
    $("#slider_width").slider
      range: "min"
      min: 50
      max: 100
      step: 2
      value: 80
      slide: (event, ui) -> window.maker.width_changed(ui.value)
    $("#slider_height").slider
      range: "min"
      min: 5
      max: 50
      value: 20
      slide: (event, ui) -> window.maker.height_changed(ui.value)
    $("#slider_radius").slider
      range: "min"
      min: 0
      max: 50
      value: 50
      slide: (event, ui) -> window.maker.radius_changed(ui.value)
    $("#slider_distance").slider
      range: "min"
      min: 0
      max: 10
      value: 0
      slide: (event, ui) -> window.maker.distance_changed(ui.value)
    $("#slider_blur").slider
      range: "min"
      min: 0
      max: 50
      value: 10
      slide: (event, ui) -> window.maker.blur_changed(ui.value)
    $("#slider_shift").slider
      range: "min"
      min: 0
      max: 50
      value: 15
      slide: (event, ui) -> window.maker.shift_changed(ui.value)
    $("#slider_opacity").slider
      range: "min"
      min: 0
      max: 100
      value: 50
      slide: (event, ui) -> window.maker.opacity_changed(ui.value)
    
    # Display the default shadow
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
    '<input id="value_index" type="checkbox" onchange="window.maker.sublayer_changed()" value="1"/>
     <label for="value_index">Display sub layer</label>
     <h2>Width <span id="value_width">80</span>%</h2>
     <div id="slider_width"></div>
     <h2>Height <span id="value_height">20</span>%</h2>
     <div id="slider_height"></div>
     <h2>Radius <span id="value_radius">50</span>%</h2>
     <div id="slider_radius"></div>
     <h2>Distance <span id="value_distance">0</span>%</h2>
     <div id="slider_distance"></div>
     <h2>Color blur <span id="value_blur">10</span>%</h2>
     <div id="slider_blur"></div>
     <h2>Color shift <span id="value_shift">15</span>%</h2>
     <div id="slider_shift"></div>
     <h2>Color opacity <span id="value_opacity">0.5</span>%</h2>
     <div id="slider_opacity"></div>
     '
  
  

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
