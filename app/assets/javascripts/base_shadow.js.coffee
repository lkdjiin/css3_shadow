########################################################################
# Base of all Shadow classes.
########################################################################
class window.BaseShadow

  # Create a new shadow, with all properties reseted.
  constructor: ->
    Tweakable.apply this
    @_reset_properties()
  
  
  # Get HTML code for a part of the UI setup (the UI to tweak the
  # shadow).
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
     <div id='slider_#{property}' class='yellow'></div>"
  
  
  # Get HTML code for the sublayer checkbox (a special case of
  # #setup_part).
  #
  # Returns String.
  setup_part_sublayer: ->
    '<input id="value_index" type="checkbox" onchange="window.maker.sublayer_changed()" value="1"/>
     <label for="value_index">Display sub layer</label>'
  

  # Reset all possible shadow properties to none.
  _reset_properties: ->
    window.sheet_mgr.reset

  
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
  
  # Get the SASS code for this particular shadow effect.
  #
  # Note sass_for_box_before() and sass_for_box_after() must be 
  # defined in childs.
  #
  # Returns String.
  to_sass: ->
    code = @sass_for_box_before()
    code += @sass_for_box_after()
  
  init: ->
    @set_the_UI()
    @_set_callbacks()
    @_display_default_shadow()
    
  css_code_for_transform: (value) ->
    "-webkit-transform: #{value};\n
     -moz-transform: #{value};\n
     -ms-transform: #{value};\n
     -o-transform: #{value};\n
     transform: #{value};\n"

  sass_code_for_transform: (value) ->
    "transform: #{value}\n"
  
  css_code_for_transform_origin: (value) ->
    "-webkit-transform-origin: #{value};\n
     -moz-transform-origin: #{value};\n
     -ms-transform-origin: #{value};\n
     -o-transform-origin: #{value};\n
     transform-origin: #{value};\n"
  
  sass_code_for_transform_origin: (value) ->
    "transform-origin: #{value}\n"
