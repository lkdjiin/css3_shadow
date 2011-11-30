################################################################################
# Base of all Shadow classes.
################################################################################
class window.BaseShadow

  # Create a new shadow, with all properties reseted.
  constructor: ->
    @_reset_properties()
  
  
  # Get HTML code for a part of the UI setup (the UI that tweak the shadow).
  #
  # label         - String name of the property displayed to the user.
  # property      - String name of the shadow property to tweak (usually
  #                 same as label but in downcase).
  # initial_value - The Integer/Float initial value of the property.
  #
  # Examples:
  #   @setup_part("Color blur", "blur", 10)
  #
  # Returns String.
  setup_part: (label, property, initial_value) ->
    "<h2>#{label} <span id='value_#{property}'>#{initial_value}</span>%</h2>
     <div id='slider_#{property}'></div>"
  
  
  # Get HTML code for the sublayer checkbox (a special case of #setup_part).
  #
  # Returns String.
  setup_part_sublayer: ->
    '<input id="value_index" type="checkbox" onchange="window.maker.sublayer_changed()" value="1"/>
     <label for="value_index">Display sub layer</label>'
  
  
  # Sets a callback for a UI setup slider. Callbacks are defined in
  # ShadwMaker class.
  #
  # property      - String name of the shadow property (see #setup_part)
  # min           - Minimal Integer value of the slider
  # max           - Minimal Integer value of the slider
  # initial_value - Initial Integer value of the slider
  # step          - Step Integer value of the slider
  #
  # See also jquery-ui slider
  set_slider_callback: (property, min, max, initial_value, step) ->
    step = 1 if step is undefined
    $("#slider_#{property}").slider
      range: "min"
      min: min
      max: max
      step: step
      value: initial_value
      slide: (event, ui) -> eval("window.maker.#{property}_changed(ui.value)")
  
  
  # Reset all possible shadow properties to none.
  _reset_properties: ->
    jss '#box:before',
      boxShadow: "none"
      borderRadius: 0
      left: "auto"
      right: "auto"
      top: "auto"
      bottom: "auto"
      width: 0
      height: 0
    jss '#box:after',
      boxShadow: "none"
      borderRadius: 0
      left: "auto"
      right: "auto"
      top: "auto"
      bottom: "auto"
      width: 0
      height: 0
      
  
  # Get CSS code of the shadowed box. Not all code! Just the box (not the 
  # :before and :after parts).
  #
  # Returns String.
  code_for_box: -> "#box {\n  position: relative;\n}\n"
  
  set_the_UI: ->
    $("#setup_shadow").html(@_setup_shadow_part())
