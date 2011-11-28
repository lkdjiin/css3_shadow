################################################################################
# Representing the base of all Shadow classes.
################################################################################
class window.BaseShadow

  constructor: ->
    @_reset_properties()
  
  setup_part_sublayer: ->
    '<input id="value_index" type="checkbox" onchange="window.maker.sublayer_changed()" value="1"/>
     <label for="value_index">Display sub layer</label>'
  
  setup_part: (label, property, initial_value) ->
    "<h2>#{label} <span id='value_#{property}'>#{initial_value}</span>%</h2>
     <div id='slider_#{property}'></div>"
  
  set_slider_callback: (property, min, max, initial_value, step) ->
    step = 1 if step is undefined
    $("#slider_#{property}").slider
      range: "min"
      min: min
      max: max
      step: step
      value: initial_value
      slide: (event, ui) -> eval("window.maker.#{property}_changed(ui.value)")
  
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
      
  code_for_box: ->
    "#box {\n  position: relative;\n}\n"
