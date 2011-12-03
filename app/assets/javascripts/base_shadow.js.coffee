################################################################################
# Base of all Shadow classes.
################################################################################
class window.BaseShadow extends window.Tweakable

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
      
  
  # Display User Interface (sliders, etc.) to be able to tweak the shadow.
  # Method #_setup_shadow_part must be defined in childs.
  set_the_UI: ->
    $("#setup_shadow").html(@_setup_shadow_part())
