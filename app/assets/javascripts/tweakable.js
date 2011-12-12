// Mixin who have got sliders to tweak some of its properties.
Tweakable = function() {
  // Sets a callback for a UI setup slider. Callbacks are defined in
  // ShadwMaker class.
  //
  // property      - String name of the shadow property (see #setup_part)
  // min           - Minimal Integer value of the slider
  // max           - Minimal Integer value of the slider
  // initial_value - Initial Integer value of the slider
  // step          - Step Integer value of the slider
  //
  // See also jquery-ui slider
  this.set_slider_callback = function(property, min, max, initial_value, step) {
    var obj;
    if (step === void 0) {
      step = 1;
    }
    if (this instanceof window.BaseShadow) {
      obj = "maker";
    } else {
      obj = "box_tweaking";
    }
    return $("#slider_" + property).slider({
      range: "min",
      min: min,
      max: max,
      step: step,
      value: initial_value,
      slide: function(event, ui) {
        return eval("window." + obj + "." + property + "_changed(ui.value)");
      }
    });
  };
  
  return this;

};
