
class window.BoxTweaking extends window.Tweakable
  
  constructor: ->
    @set_slider_callback("box_width", 200, 800, 400, 10)
    @set_slider_callback("box_height", 200, 800, 300, 10)
  
  box_width_changed: (value) ->
    $("#box").width(value)
    $("#value_box_width").html(value)
  
  box_height_changed: (value) ->
    $("#box").height(value)
    $("#value_box_height").html(value)
