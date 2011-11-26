class window.Shadow

  width_changed: (width) ->
    $("#value_width").html(width)
    left = (100 - width) / 2
    jss '#box:before, #box:after',
      width: width + '%'
      left: left + '%'
      
  height_changed: (height) ->
    $("#value_height").html(height)
    jss '#box:before, #box:after',
      height: height + '%'
  
  radius_changed: (value) ->
    $("#value_radius").html(value)
    jss '#box:before, #box:after',
      borderRadius: value + '%'
  

