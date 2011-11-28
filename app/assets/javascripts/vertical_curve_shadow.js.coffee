################################################################################
# Representing the state of an Vertical Curved Shadow.
################################################################################
class window.VerticalCurveShadow extends window.BaseShadow

  constructor: ->
    super()
    
    # Members
    @top = 10
    @bottom = 10
    
    # Set the UI
    $("#setup_shadow").html(@_setup_shadow_part())
    
    # Set callbacks
    $("#slider_height").slider
      range: "min"
      min: 0
      max: 100
      step: 2
      value: 80
      slide: (event, ui) -> window.maker.height_changed(ui.value)

  set_height: (value) ->
    value = (100 - value) / 2
    @top = value
    @bottom = value
    jss '#box:before',
      top: value + '%'
      bottom: value + '%'
      
  # Get the CSS3 code for this particular shadow effect.
  #
  # Returns String.
  to_string: ->
    code = @code_for_box()
    code += @code_for_box_before()
    code += @code_for_box_after()
  
  # private
  
  _setup_shadow_part: ->
    "<input id='value_index' type='checkbox' onchange='window.maker.sublayer_changed()' value='1'/>
     <label for='value_index'>Display sub layer</label>
     <h2>Height <span id='value_height'>80</span>%</h2>
     <div id='slider_height'></div>"
