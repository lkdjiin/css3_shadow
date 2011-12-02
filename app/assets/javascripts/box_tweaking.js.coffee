
class window.BoxTweaking extends window.Tweakable
  
  constructor: ->
    @set_slider_callback("box_width", 200, 800, 400, 10)
  
  box_width_changed: (value) ->
    $("#box").width(value)
    $("#value_box_width").html(value)
    
