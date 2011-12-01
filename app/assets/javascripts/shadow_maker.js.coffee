################################################################################
# The application main class, the one who is the 'façade'.
# For now, it is the only public class.
################################################################################
class window.ShadowMaker

  # Create a new 'façade' for the application along with a default shadow.
  constructor: ->
    @maker = new window.HorizontalCurveShadow('both')


  # Callback, when the width of the shadow have changed.
  #
  # width - Integer.
  width_changed: (width) ->
    @maker.set_width(width)
    $("#value_width").html(width)
  
  
  # Callback, when the height of the shadow have changed.
  #
  # height - Integer.
  height_changed: (height) ->
    @maker.set_height(height)
    $("#value_height").html(height)
  
  
  # Callback, when the radius of the shadow have changed.
  #
  # value - Integer.
  radius_changed: (value) ->
    @maker.set_radius(value)
    $("#value_radius").html(value)
  
  
  # Callback, when the distance of the shadow from the side of the box have changed.
  #
  # value - Integer.
  distance_changed: (value) ->
    @maker.set_distance(value)
    $("#value_distance").html(value)
  
  
  # Callback, when the blur of the shadow color have changed.
  #
  # value - Integer.
  blur_changed: (value) ->
    @maker.set_blur(value)
    $("#value_blur").html(value)
  
  
  # Callback, when the shift of the shadow color have changed.
  #
  # value - Integer.
  yshift_changed: (value) ->
    @maker.set_yshift(value)
    $("#value_yshift").html(value)
  
  
  # Callback, when the opacity of the shadow color have changed.
  #
  # value - Integer.
  opacity_changed: (value) ->
    @maker.set_opacity(value)
    $("#value_opacity").html(value)
      
      
  # Callback, when the 'sublayer' checkbox have changed.
  # If it is checked, we display all the underlying stuff to the user.
  sublayer_changed: ->
    value = if $("#value_index").is(":checked") then 1 else -1
    jss '#box:before',
      zIndex: value
    jss '#box:after',
      zIndex: value
  
  
  # Callback, when the user change the shadow shape.
  shape_changed: ->
    $('#code pre code div').html('')
    switch $('select#shape').val()
      when 'curved_hz' then @maker = new window.HorizontalCurveShadow('both')
      when 'curved_hz_bottom' then @maker = new window.HorizontalCurveShadow('bottom')
      when 'curved_hz_top' then @maker = new window.HorizontalCurveShadow('top')
      when 'curved_vt' then @maker = new window.VerticalCurveShadow()
  
  
  # Displays the code to the user.
  show_code: ->
    $("#code div").html(@maker.to_string())

  
