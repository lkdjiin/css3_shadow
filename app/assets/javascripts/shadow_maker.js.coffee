################################################################################
# The application main class, the one who is the 'façade'.
################################################################################
class window.ShadowMaker

  # Create a new 'façade' for the application along with a default shadow.
  #
  # properties - Array of String of the shadow properties that can be changed 
  #              by user.
  constructor: (properties)->
    @maker = new window.HorizontalCurveShadow('both')
    @create_changer(prop) for prop in properties
    

  # Create the callback method for a property that can be changed by user.
  # 
  # property - The String name of the property we can change.
  #
  # Examples
  #   @create_changer("left") 
  #   # Creates the following method for this class:
  #   left_changed: (value) ->
  #     @maker.set_left(value)
  #     $("#value_left").html(value)
  #
  # TODO I know eval() is bad. If you can do a better code,
  #     please do it and let me know.
  create_changer: (property)->
    this.constructor::["#{property}_changed"] = (value) ->
      eval("this.maker.set_#{property}(value);")
      eval("$(\"#value_#{property}\").html(value);")

      
  # Callback, when the 'sublayer' checkbox have changed.
  # If it is checked, we display all the underlying stuff to the user.
  sublayer_changed: ->
    value = if $("#value_index").is(":checked") then "1" else "-1"
    window.sheet_mgr.set_after_and_before "zIndex", value
  
  
  # Callback, when the user change the shadow shape.
  # Performs some transition animation too.
  #
  # TODO Find a solution to not open this class when adding a new type of shadow.
  shape_changed: ->
    $('#code pre code div').html('')
    $('#setup_shadow').animate({opacity: 0}, 300, 'linear', =>
      @maker = switch $('select#shape').val()
        when 'curved_hz' then new window.HorizontalCurveShadow('both')
        when 'curved_hz_bottom' then new window.HorizontalCurveShadow('bottom')
        when 'curved_hz_top' then new window.HorizontalCurveShadow('top')
        when 'perspective' then new window.PerspectiveShadow('left')
        when 'curled' then new window.CurledCornersShadow()
        when 'perspective_r' then new window.PerspectiveShadow('right')
        when 'curved_vt' then new window.VerticalCurveShadow()
      $('#setup_shadow').animate({opacity: 1})
    )
    

  # Displays the code to the user.
  show_code: ->
    code = window.box_tweaking.to_string() + @maker.to_string()
    $("#code div").html(code)

  
  
