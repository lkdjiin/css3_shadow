################################################################################
# The box, which will be shadowed.
################################################################################
class window.BoxTweaking
  
  # Create a new box, ready to be tweaked.
  constructor: ->
    Tweakable.apply this
    
    @top_left_hz = 3
    @top_left_vt = 3
    @top_right_hz = 3
    @top_right_vt = 3
    @bottom_left_hz = 3
    @bottom_left_vt = 3
    @bottom_right_hz = 3
    @bottom_right_vt = 3
    
    @set_slider_callback("box_width", 200, 800, 400, 10)
    @set_slider_callback("box_height", 200, 800, 300, 10)
    
    @set_slider_callback("box_top_left_hz", 0, 50, 3)
    @set_slider_callback("box_top_right_hz", 0, 50, 3)
    @set_slider_callback("box_bottom_right_hz", 0, 50, 3)
    @set_slider_callback("box_bottom_left_hz", 0, 50, 3)
    
    @set_slider_callback("box_top_left_vt", 0, 50, 3)
    @set_slider_callback("box_top_right_vt", 0, 50, 3)
    @set_slider_callback("box_bottom_right_vt", 0, 50, 3)
    @set_slider_callback("box_bottom_left_vt", 0, 50, 3)
  
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
    "#box {\n
      position: relative;\n
      width: #{$('#value_box_width').html()}px;\n
      height: #{$('#value_box_height').html()}px;\n
      background-color: #fff;\n
      box-shadow: 0 1px 5px rgba(0,0,0,0.25), 0 0 50px rgba(0,0,0,0.1) inset;\n
    }\n"
  
  set_default: ->
    $('#box').css({
      borderRadius: "5px"
    })
    
  value_for_border_radius: ->
    "#{@top_left_hz}% 
    #{@top_right_hz}% 
    #{@bottom_right_hz}% 
    #{@bottom_left_hz}% / 
    #{@top_left_vt}% 
    #{@top_right_vt}% 
    #{@bottom_right_vt}% 
    #{@bottom_left_vt}%"
