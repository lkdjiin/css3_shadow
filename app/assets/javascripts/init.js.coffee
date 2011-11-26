$(document).ready ->
  window.shadow = new window.Shadow()
  
  $("#slider_width").slider
    range: "min"
    min: 50
    max: 100
    step: 2
    value: 80
    slide: (event, ui) ->
      window.shadow.width_changed(ui.value)
      
  $("#slider_height").slider
    range: "min"
    min: 5
    max: 50
    value: 20
    slide: (event, ui) ->
      window.shadow.height_changed(ui.value)
      
  $("#slider_radius").slider
    range: "min"
    min: 0
    max: 50
    value: 50
    slide: (event, ui) ->
      window.shadow.radius_changed(ui.value)
