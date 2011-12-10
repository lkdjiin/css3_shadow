################################################################################
# Apply CSS rules to after and before pseudo elements of the box.
#
# See also stylesheet_constants.js
################################################################################
class window.StylesheetManager
  
  # Construct a new StylesheetManager. Insert the needed rules to
  # the existing styleesheet(s).
  constructor: ->
    @_create_empty_rules()


  # Set a property of a rule.
  #
  # ssc   - A constant [SSC.AFTER | SSC.BEFORE] telling which rule to update.
  # prop  - The String css property to update. The property must me given
  #         'à la javascript': "zIndex" -> good, "z-index" -> bad, don't work.
  # value - The String new value of the property.
  set: (ssc, prop, value) ->
    document.styleSheets[0].cssRules[ssc].style[prop] = value
  
  
  # Set the same property for before and after rule.
  #
  # prop  - The String css property to update. The property must me given
  #         'à la javascript': "zIndex" -> good, "z-index" -> bad, don't work.
  # value - The String new value of the property.
  #
  # See also set().
  set_after_and_before: (prop, value) ->
    @set SSC.BEFORE, prop, value
    @set SSC.AFTER, prop, value
  
  
  # After completion, after and before rules will be empty.
  reset: ->
    @delete_rules()
    @_empty_rules()
  
  
  _create_empty_rules: ->
    document.styleSheets[0].insertRule("#box:after {  }", SSC.AFTER)
    document.styleSheets[0].insertRule("#box:before {  }", SSC.BEFORE)
  
  
  # Delete after and before rules. After completion, they no longer exist.
  delete_rules: ->
    document.styleSheets[0].deleteRule(SSC.BEFORE)
    document.styleSheets[0].deleteRule(SSC.AFTER)
  
  # Set many properties for after and before rules in one shot.
  #
  # after  - A String set of css instruction.
  # before - Same as after.
  #
  # Examples:
  #   after = "width: 80px; height: 10%; z-index: 99;"
  #   before = "height: 10%"
  #   window.sheet_mgr.insert_after_and_before_rules after, before
  insert_after_and_before_rules: (after, before) ->
    document.styleSheets[0].insertRule("#box:after { #{after} }", SSC.AFTER)
    document.styleSheets[0].insertRule("#box:before { #{before} }", SSC.BEFORE)
  

