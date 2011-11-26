class Shadow
  width_changed: (width) ->
    $("#value_width").html(width)
    jss('#box:before', {
        width: width + '%'
    });
  
$(document).ready ->
  window.shadow = new Shadow()
  $("#slider_width").slider
    range: "min"
    min: 50
    max: 100
    value: 80
    slide: (event, ui) ->
      window.shadow.width_changed(ui.value)
