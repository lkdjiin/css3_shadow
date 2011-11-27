################################################################################
# The application main class, the one who is the 'façade'.
# For now, it is the only public class.
class window.ShadowMaker

  constructor: ->
    @shadow = new HorizontalCurveShadow()

  # Callback, when the width of the shadow have changed.
  #
  # width - Integer.
  width_changed: (width) ->
    @shadow.width = width
    $("#value_width").html(width)
    left = (100 - width) / 2
    @shadow.left = left
    jss '#box:before, #box:after',
      width: width + '%'
      left: left + '%'
  
  # Callback, when the height of the shadow have changed.
  #
  # height - Integer.
  height_changed: (height) ->
    @shadow.height = height
    $("#value_height").html(height)
    jss '#box:before, #box:after',
      height: height + '%'
  
  # Callback, when the radius of the shadow have changed.
  #
  # value - Integer.
  radius_changed: (value) ->
    @shadow.radius = value
    $("#value_radius").html(value)
    jss '#box:before, #box:after',
      borderRadius: value + '%'
  
  # Callback, when the distance of the shadow from the side of the box have changed.
  #
  # value - Integer.
  distance_changed: (value) ->
    @shadow.distance = value
    $("#value_distance").html(value)
    jss '#box:before',
      top: value + '%'
    jss '#box:after',
      bottom: value + '%'
  
  # Callback, when the blur of the shadow color have changed.
  #
  # value - Integer.
  blur_changed: (value) ->
    @shadow.blur = value
    $("#value_blur").html(value)
    jss '#box:before',
      boxShadow: @_color_for_before()
    jss '#box:after',
      boxShadow: @_color_for_after()
  
  # Callback, when the shift of the shadow color have changed.
  #
  # value - Integer.
  shift_changed: (value) ->
    @shadow.shift = value
    $("#value_shift").html(value)
    jss '#box:before',
      boxShadow: @_color_for_before()
    jss '#box:after',
      boxShadow: @_color_for_after()
  
  # Callback, when the opacity of the shadow color have changed.
  #
  # value - Integer.
  opacity_changed: (value) ->
    value /= 100
    @shadow.opacity = value
    $("#value_opacity").html(value)
    jss '#box:before',
      boxShadow: @_color_for_before()
    jss '#box:after',
      boxShadow: @_color_for_after()
      
  # Callback, when the 'sublayer' checkbox have changed.
  # If it is checked, we display all the underlying stuff to the user.
  sublayer_changed: ->
    if $("#value_index").is(":checked")
      jss '#box:before, #box:after',
        zIndex: 1
    else
      jss '#box:before, #box:after',
        zIndex: -1
  
  # Displays the code to the user.
  show_code: ->
    $("#code div").html(@shadow.to_string())
  
  # private
  
  _color_for_before: ->
    "0 -#{@shadow.shift}px #{@shadow.blur}px rgba(0,0,0,#{@shadow.opacity})"
  
  _color_for_after: ->
    "0 #{@shadow.shift}px #{@shadow.blur}px rgba(0,0,0,#{@shadow.opacity})"


################################################################################
# Representing the state of an Horizontal Curve Shadow.
class HorizontalCurveShadow

  constructor: ->
    @width = 80
    @height = 20
    @radius = 50
    @left = 10
    @distance = 0
    @blur = 10
    @shift = 15
    @opacity = 0.5
  
  # Get the CSS3 code for this particular shadow effect.
  #
  # Returns String.
  to_string: ->
    code = @_code_for_box()
    code += @_code_for_box_before()
    code += @_code_for_box_after()
  
  # private
  
  _code_for_box: ->
    "#box {\n  position: relative;\n}\n"

  _code_for_box_before: ->
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

  _code_for_box_after: ->
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
