################################################################################
# Representing the state of a Perspective Shadow.
################################################################################
class window.PerspectiveShadow extends window.BaseShadow

  # Create a new shadow.
  constructor: ->
    super()
    @left = 80
    @bottom = 5
    @width = 50
    @height = 35
    @xshift = 80
    @blur = 8
    @opacity = 0.4
    @skew = 50
    @xorigin = 0
    @yorigin = 100
  
    @set_the_UI() # @TODO find a way to call this in parent
    @_set_callbacks()
    @_display_default_shadow()
  
  
  # value - Integer.
  # @TODO think of a way to make this automatic
  set_left: (value) ->
    @left = value
    jss '#box:before',
      left: value + 'px'
  
  # value - Integer.
  set_bottom: (value) ->
    @bottom = value
    jss '#box:before',
      bottom: value + 'px'
      
  # value - Integer.
  set_width: (value) ->
    @width = value
    jss '#box:before',
      width: value + '%'
  
  # value - Integer.
  set_height: (value) ->
    @height = value
    jss '#box:before',
      height: value + '%'
      
  # Get the CSS3 code for this particular shadow effect.
  #
  # Returns String.
  # @TODO I think this could be in the parent.
  to_string: ->
    code = @code_for_box_before()
    code += @code_for_box_after()
  
  # Set the UI (sliders, etc.) to tweak the shadow.
  _setup_shadow_part: ->
    (@setup_part_sublayer() +
    @setup_part("Left", "left", @left) +
    @setup_part("Bottom", "bottom", @bottom) +
    @setup_part("Width", "width", @width) +
    @setup_part("Height", "height", @height))
    
  # Set callback methods (mostly on sliders) to know what to do when values
  # changed.
  _set_callbacks: ->
    @set_slider_callback("left", 0, 100, @left)
    @set_slider_callback("bottom", 0, 100, @bottom)
    @set_slider_callback("width", 0, 100, @width)
    @set_slider_callback("height", 0, 100, @height)
  
  # Display a shadow on the box with default values.
  _display_default_shadow: ->
    jss '#box:before',
      left: "#{@left}px"
      bottom: "#{@bottom}px"
      width: "#{@width}%"
      height: "#{@height}%"
      boxShadow: "-#{@xshift}px 0 #{@blur}px rgba(0,0,0,#{@opacity})"
      MozTransform: "skew(#{@skew}deg)"
      MozTransformOrigin: "#{@xorigin}% #{@yorigin}%"
      zIndex: -1
  
