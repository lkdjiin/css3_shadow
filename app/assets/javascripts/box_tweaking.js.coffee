################################################################################
# The box, which will be shadowed.
################################################################################
class window.BoxTweaking extends window.Tweakable
  
  # Create a new box, ready to be tweaked.
  constructor: ->
    @set_slider_callback("box_width", 200, 800, 400, 10)
    @set_slider_callback("box_height", 200, 800, 300, 10)
  
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
    
  # Get CSS code of the shadowed box. Not all code! Just the box (not the 
  # :before and :after parts).
  #
  # Returns String.
  to_string: ->
    "#box {\n
      position: relative;\n
      width: #{$('#value_box_width').html()}px;\n
      height: #{$('#value_box_height').html()}px;\n
    }\n"