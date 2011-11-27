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
  
  

# Representing the state of an Horizontal Curve Shadow.
class HorizontalCurveShadow

  constructor: ->
    @width = 80
    @height = 20
    @radius = 50
    @left = 10
    @distance = 0
  
  # Get the CSS3 code for this particular shadow effect.
  #
  # Returns String.
  to_string: ->
    code = @_code_for_box()
    code += @_code_for_box_before()
    code += @_code_for_box_after()
  
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
    }\n"
