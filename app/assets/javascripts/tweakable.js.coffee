
class window.Tweakable

  constructor: ->

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
    if this instanceof BaseShadow
      obj = "maker"
    else
      obj = "box_tweaking"
    $("#slider_#{property}").slider
      range: "min"
      min: min
      max: max
      step: step
      value: initial_value
      slide: (event, ui) -> eval("window.#{obj}.#{property}_changed(ui.value)")
