################################################################################
# Representing the base of all Shadow classes.
################################################################################
class window.BaseShadow

  constructor: ->
    @_reset_properties()
  
  _reset_properties: ->
    jss '#box:before, #box:after',
      boxShadow: "0 0 0 rgba(0,0,0,1)"
      borderRadius: 0
      left: "auto"
      right: "auto"
      top: "auto"
      bottom: "auto"
      width: 0
      height: 0
      
  code_for_box: ->
    "#box {\n  position: relative;\n}\n"
