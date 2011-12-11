/*******************************************************************************
 * StyleSheetConstants.
 * A list of constant values for using stylesheet features.
 ******************************************************************************/
var SSC = (function() {
  
  /*
   * Get the "vendor" (or standard) property supported by the browser.
   * 
   * prop_array - the String array of property to test.
   * 
   * Examples:
   *   property = get_supported_prop(['boxShadow', 'MozBoxShadow', 
   *                                  'WebkitBoxShadow']);
   * 
   * Returns the String supported property.
   */
  function get_supported_prop ( prop_array ) {
    var root = document.documentElement
    for ( var i = 0; i < prop_array.length; i++ ) {
      if ( typeof root.style[prop_array[i]] == "string" ) {
        return prop_array[i]
      }
    }
  }
  
  /*
   * Translate a javascript property name into a css property name.
   * 
   * name - The String javascript property name.
   * 
   * Examples:
   *   js2css_property( "MozTransform" );
   *   => "-moz-transform"
   * 
   *   js2css_property( "borderRadius" );
   *   => "border-radius"
   * 
   * Returns the String CSS property name.
   */
  function js2css_property ( name ) {
    return name.replace(/([A-Z])/g, "-$1").toLowerCase();
  }
  
  /*****************************************************************************
   * PUBLIC
   ****************************************************************************/
  return {
    AFTER: 0,  // :after pseudo-element
    BEFORE: 1, // :before pseudo-element
    
    BOX_SHADOW: "boxShadow",
    CSS_BOX_SHADOW: "box-shadow",
    
    TRANSFORM: "transform",
    CSS_TRANSFORM: "transform",
    
    TRANSFORM_ORIGIN: "transformOrigin",
    CSS_TRANSFORM_ORIGIN: "transform-origin",
    
    BORDER_RADIUS: "borderRadius",
    CSS_BORDER_RADIUS: "border-radius",
    
    /*
     * Initialize constants for "vendor properties".
     */
    "init": function () {
      SSC.BOX_SHADOW = get_supported_prop(['boxShadow', 'MozBoxShadow', 'WebkitBoxShadow']);
      SSC.CSS_BOX_SHADOW = js2css_property( SSC.BOX_SHADOW );
      
      SSC.TRANSFORM = get_supported_prop(['transform', 'MozTransform', 'WebkitTransform',
                                          'MsTransform', 'OTransform']);
      SSC.CSS_TRANSFORM = js2css_property( SSC.TRANSFORM );
      
      SSC.TRANSFORM_ORIGIN = get_supported_prop(['transformOrigin', 'MozTransformOrigin', 
                                                 'WebkitTransformOrigin', 'MsTransformOrigin', 
                                                 'OTransformOrigin']);
      SSC.CSS_TRANSFORM_ORIGIN = js2css_property( SSC.TRANSFORM_ORIGIN );
      
      SSC.BORDER_RADIUS = get_supported_prop(['borderRadius', 'MozBorderRadius', 
                                              'WebkitBorderRadius']);
      SSC.CSS_BORDER_RADIUS = js2css_property( SSC.BORDER_RADIUS );
    }
  };
  
})();
