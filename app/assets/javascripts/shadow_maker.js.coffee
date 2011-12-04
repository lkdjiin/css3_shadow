################################################################################
# The application main class, the one who is the 'façade'.
# For now, it is the only public class.
################################################################################
class window.ShadowMaker

  # Create a new 'façade' for the application along with a default shadow.
  constructor: ->
    @maker = new window.HorizontalCurveShadow('both')


  # Callback, when the left of the shadow have changed.
  #
  # value - Integer.
  # @TODO Most of the *_changed method are identical
  left_changed: (value) ->
    @maker.set_left(value)
    $("#value_left").html(value)
    
  # Callback, when the bottom of the shadow have changed.
  #
  # value - Integer.
  # @TODO Most of the *_changed method are identical
  bottom_changed: (value) ->
    @maker.set_bottom(value)
    $("#value_bottom").html(value)

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
  # Performs some transition animation too.
  #
  # @TODO Find a solution to not open this class when adding a new type of shadow.
  shape_changed: ->
    $('#code pre code div').html('')
    $('#setup_shadow').animate({opacity: 0}, 300, 'linear', =>
      @maker = switch $('select#shape').val()
        when 'curved_hz' then new window.HorizontalCurveShadow('both')
        when 'curved_hz_bottom' then new window.HorizontalCurveShadow('bottom')
        when 'curved_hz_top' then new window.HorizontalCurveShadow('top')
        when 'perspective' then new window.PerspectiveShadow()
        when 'curved_vt' then new window.VerticalCurveShadow()
      $('#setup_shadow').animate({opacity: 1})
    )
    

  # Displays the code to the user.
  show_code: ->
    code = window.box_tweaking.to_string() + @maker.to_string()
    $("#code div").html(code)

  
  
