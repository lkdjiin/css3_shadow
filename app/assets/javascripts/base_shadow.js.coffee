################################################################################
# Base of all Shadow classes.
################################################################################
class window.BaseShadow extends window.Tweakable

  # Create a new shadow, with all properties reseted.
  constructor: ->
    @_reset_properties()
  
  
  # Get HTML code for a part of the UI setup (the UI to tweak the shadow).
  #
  # label         - String name of the property displayed to the user.
  # property      - String name of the shadow property to tweak (usually
  #                 same as label but in downcase).
  # initial_value - The Integer/Float initial value of the property.
  # unit          - The String unit of the property ('%' per default)
  #
  # Examples:
  #   @setup_part("Color blur", "blur", 10)
  #
  # Returns String.
  setup_part: (label, property, initial_value, unit) ->
    unit = '%' if unit is undefined
    "<h2>#{label} <span id='value_#{property}'>#{initial_value}</span>#{unit}</h2>
     <div id='slider_#{property}'></div>"
  
  
  # Get HTML code for the sublayer checkbox (a special case of #setup_part).
  #
  # Returns String.
  setup_part_sublayer: ->
    '<input id="value_index" type="checkbox" onchange="window.maker.sublayer_changed()" value="1"/>
     <label for="value_index">Display sub layer</label>'
  

  # Reset all possible shadow properties to none.
  _reset_properties: ->
    options =
      boxShadow: "none"
      borderRadius: 0
      left: "auto"
      right: "auto"
      top: "auto"
      bottom: "auto"
      width: 0
      height: 0
      MozTransform: "none"
      MozTransformOrigin: "none"
    jss '#box:before', options
    jss '#box:after', options

  
  # Display User Interface (sliders, etc.) to be able to tweak the shadow.
  # Method #_setup_shadow_part must be defined in childs.
  set_the_UI: ->
    $("#setup_shadow").html(@_setup_shadow_part())
  
  
  # Get the CSS3 code for this particular shadow effect.
  #
  # Note code_for_box_before() and code_for_box_after() must be 
  # defined in childs.
  #
  # Returns String.
  to_string: ->
    code = @code_for_box_before()
    code += @code_for_box_after()
  
  init: ->
    @set_the_UI()
    @_set_callbacks()
    @_display_default_shadow()
