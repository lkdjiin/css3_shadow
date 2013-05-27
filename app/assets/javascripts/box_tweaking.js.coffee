########################################################################
# The box, which will be shadowed.
########################################################################
class window.BoxTweaking
  
  # Create a new box, ready to be tweaked.
  constructor: ->
    Tweakable.apply this
    
    @top_left_hz = 1
    @top_left_vt = 1
    @top_right_hz = 1
    @top_right_vt = 1
    @bottom_left_hz = 1
    @bottom_left_vt = 1
    @bottom_right_hz = 1
    @bottom_right_vt = 1
    
    @set_slider_callback("box_width", 200, 800, 400, 10)
    @set_slider_callback("box_height", 200, 800, 300, 10)
    
    @set_slider_callback("box_top_left_hz", 0, 50, 1)
    @set_slider_callback("box_top_right_hz", 0, 50, 1)
    @set_slider_callback("box_bottom_right_hz", 0, 50, 1)
    @set_slider_callback("box_bottom_left_hz", 0, 50, 1)
    
    @set_slider_callback("box_top_left_vt", 0, 50, 1)
    @set_slider_callback("box_top_right_vt", 0, 50, 1)
    @set_slider_callback("box_bottom_right_vt", 0, 50, 1)
    @set_slider_callback("box_bottom_left_vt", 0, 50, 1)
  
  # Callback, when the width of the box have changed.
  #
  # value - Integer.
  box_width_changed: (value) ->
    $("#box").width(value)
    $("#value_box_width").html(value)
  
  # Callback, when the height of the box have changed.
  #
  # value - Integer.
  box_height_changed: (value) ->
    $("#box").height(value)
    $("#value_box_height").html(value)
  
  # value - Integer.
  box_top_left_hz_changed: (value) ->
    @top_left_hz = value
    @update_radius_UI('top_left_hz', value)
  
  # value - Integer.
  box_top_right_hz_changed: (value) ->
    @top_right_hz = value
    @update_radius_UI('top_right_hz', value)
  
  # value - Integer.
  box_bottom_right_hz_changed: (value) ->
    @bottom_right_hz = value
    @update_radius_UI('bottom_right_hz', value)
  
  # value - Integer.
  box_bottom_left_hz_changed: (value) ->
    @bottom_left_hz = value
    @update_radius_UI('bottom_left_hz', value)
  
  # value - Integer.
  box_top_left_vt_changed: (value) ->
    @top_left_vt = value
    @update_radius_UI('top_left_vt', value)
  
  # value - Integer.
  box_top_right_vt_changed: (value) ->
    @top_right_vt = value
    @update_radius_UI('top_right_vt', value)

  # value - Integer.
  box_bottom_right_vt_changed: (value) ->
    @bottom_right_vt = value
    @update_radius_UI('bottom_right_vt', value)

  # value - Integer.
  box_bottom_left_vt_changed: (value) ->
    @bottom_left_vt = value
    @update_radius_UI('bottom_left_vt', value)

  update_radius_UI: (corner, value) ->
    $("#box").css({ borderRadius: @value_for_border_radius() })
    $("#value_box_#{corner}").html(value)

  # Get CSS code of the shadowed box. Not all code! Just the box (not the 
  # :before and :after parts).
  #
  # Returns String.
  to_string: ->
    "/* This code is tested with latest versions of\n
    Firefox, Chromium and Opera */\n
.box {\n
  position: relative;\n
  width: #{$('#value_box_width').html()}px;\n
  height: #{$('#value_box_height').html()}px;\n
  background-color: #fff;\n
  box-shadow: 0 1px 5px rgba(0,0,0,0.25), 0 0 50px rgba(0,0,0,0.1) inset;\n
  border-radius: #{@value_for_border_radius()};\n
}\n"

  # Get SASS code of the shadowed box. Not all code! Just the box (not the 
  # :before and :after parts).
  #
  # Returns String.
  to_sass: ->
    ".box\n
  position: relative\n
  width: #{$('#value_box_width').html()}px\n
  height: #{$('#value_box_height').html()}px\n
  background-color: #fff\n
  box-shadow: 0 1px 5px rgba(0,0,0,0.25), 0 0 50px rgba(0,0,0,0.1) inset\n
  border-radius: #{@value_for_border_radius()}\n\n"
  

  # Set default border-radius of the box
  set_default: ->
    @set_radius(1,1,1,1,1,1,1,1)

  # Set border-radius of the box
  #
  # htl - Integer horizontal top left value of the radius
  # htr - Integer horizontal top right value of the radius
  # hbr - Integer horizontal bottom right value of the radius
  # hbl - Integer horizontal bottom left value of the radius
  # vtl - Integer vertical top left value of the radius
  # vtr - Integer vertical top right value of the radius
  # vbr - Integer vertical bottom right value of the radius
  # vbl - Integer vertical bottom left value of the radius
  # Note: All values are in %.
  set_radius: (htl, htr, hbr, hbl, vtl, vtr, vbr, vbl) ->
    $('#box').css({
      borderRadius: "{htl}% {htr}% {hbr}% {hbl}% / {vtl}% {vtr}% {vbr}% {vbl}%"
    })
    @box_top_left_hz_changed(htl)
    $("#slider_box_top_left_hz").slider("value", htl)
    @box_top_right_hz_changed(htr)
    $("#slider_box_top_right_hz").slider("value", htr)
    @box_bottom_right_hz_changed(hbr)
    $("#slider_box_bottom_right_hz").slider("value", hbr)
    @box_bottom_left_hz_changed(hbl)
    $("#slider_box_bottom_left_hz").slider("value", hbl)
    @box_top_left_vt_changed(vtl)
    $("#slider_box_top_left_vt").slider("value", vtl)
    @box_top_right_vt_changed(vtr)
    $("#slider_box_top_right_vt").slider("value", vtr)
    @box_bottom_right_vt_changed(vbr)
    $("#slider_box_bottom_right_vt").slider("value", vbr)
    @box_bottom_left_vt_changed(vbl)
    $("#slider_box_bottom_left_vt").slider("value", vbl)

  # Get value for border-radius CSS rule, like "0% 2% 0% 2% / 0% 2% 0% 2%"
  #
  # Returns String.
  value_for_border_radius: ->
    "#{@top_left_hz}% 
    #{@top_right_hz}% 
    #{@bottom_right_hz}% 
    #{@bottom_left_hz}% / 
    #{@top_left_vt}% 
    #{@top_right_vt}% 
    #{@bottom_right_vt}% 
    #{@bottom_left_vt}%"
