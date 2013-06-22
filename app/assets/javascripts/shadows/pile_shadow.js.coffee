########################################################################
# Representing the state of a pile Shadow.
########################################################################
class window.PileShadow extends window.BaseShadow

  constructor: ->
    super()

    @width = 98
    @height = 96
    @bottom = 0
    @right = 0
    @opacity = 0.1
    @blur = 8
    @skew = 2
    @xtranslate = 3
    @ytranslate = 8

    @init()
    window.box_tweaking.set_radius(0,0,1,0,0,0,20,0)

  # value - Integer.
  set_width: (value) ->
    @width = value
    window.sheet_mgr.set SSC.BEFORE, "width", "#{value}%"
    window.sheet_mgr.set SSC.AFTER, "width", "#{value}%"
  
  # value - Integer.
  set_height: (value) ->
    @height = value
    window.sheet_mgr.set SSC.BEFORE, "height", "#{value}%"
    window.sheet_mgr.set SSC.AFTER, "height", "#{value}%"
  
  # value - Integer.
  set_bottom: (value) ->
    @bottom = value
    window.sheet_mgr.set SSC.BEFORE, "bottom", "#{value}px"
    window.sheet_mgr.set SSC.AFTER, "bottom", "#{value}px"
  
  # value - Integer.
  set_distance: (value) ->
    @right = value
    window.sheet_mgr.set SSC.BEFORE, "right", "#{value}px"
    window.sheet_mgr.set SSC.AFTER, "right", "#{value}px"
  
  # value - Integer.
  set_opacity: (value) ->
    @opacity = value / 100
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.BOX_SHADOW, @_color_for_after()

  # value - Integer.
  set_blur: (value) ->
    @blur = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.BOX_SHADOW, @_color_for_after()

  # value - Integer.
  set_skew: (value) ->
    @skew = value
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM, @_transform_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.TRANSFORM, @_transform_for_after()

  # value - Integer.
  set_xtranslate: (value) ->
    @xtranslate = value
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM, @_transform_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.TRANSFORM, @_transform_for_after()

  # value - Integer.
  set_ytranslate: (value) ->
    @ytranslate = value
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM, @_transform_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.TRANSFORM, @_transform_for_after()

  # Set the UI (sliders, etc.) to tweak the shadow.
  _setup_shadow_part: ->
    (@setup_part_sublayer() +
    @setup_part("Bottom", "bottom", @bottom, 'px') +
    @setup_part("Distance", "distance", @right, 'px') +
    @setup_part("Color opacity", "opacity", @opacity) +
    @setup_part("Color blur", "blur", @blur) +
    @setup_part("Skew", "skew", @skew, 'deg') +
    @setup_part("X translate", "xtranslate", @xtranslate, 'px') +
    @setup_part("Y translate", "ytranslate", @ytranslate, 'px') +
    @setup_part("Width", "width", @width, '%') +
    @setup_part("Height", "height", @height, '%'))
    
  # Set callback methods (mostly on sliders) to know what to do when values
  # changed.
  _set_callbacks: ->
    @set_slider_callback("bottom", -50, 50, @bottom)
    @set_slider_callback("distance", -50, 50, @right)
    @set_slider_callback("width", 10, 100, @width)
    @set_slider_callback("height", 5, 100, @height)
    @set_slider_callback("opacity", 0, 100, @opacity * 100)
    @set_slider_callback("blur", 0, 50, @blur)
    @set_slider_callback("skew", -30, 30, @skew)
    @set_slider_callback("xtranslate", -50, 50, @xtranslate)
    @set_slider_callback("ytranslate", -50, 50, @ytranslate)
  
  # Display a shadow on the box with default values.
  _display_default_shadow: ->
    window.sheet_mgr.delete_rules()
    after = "z-index: -1;
    bottom: #{@bottom}px;
    right: #{@right}px;
    width: 98%;
    height: 96%;
    background: #eee;
    border: 1px solid #ccc;
    #{SSC.CSS_BOX_SHADOW}: 0 0 8px rgba(0, 0, 0, #{@opacity});
    border-bottom-right-radius: 5px 60px;
    #{SSC.CSS_TRANSFORM}: skew(2deg,2deg) translate(-1px,2px);
    "
    before = "z-index: -1;
    bottom: #{@bottom}px;
    right: #{@right}px;
    width: 98%;
    height: 96%;
    background: #eee;
    border: 1px solid #ccc;
    #{SSC.CSS_BOX_SHADOW}: 1px 1px 8px rgba(0, 0, 0, #{@opacity});
    border-bottom-right-radius: 2px 60px;
    #{SSC.CSS_TRANSFORM}: skew(2deg,2deg) translate(3px,8px);
    "
    window.sheet_mgr.insert_after_and_before_rules after, before

  # The CSS 'box-shadow' value for 'box:before'.
  #
  # Returns String.
  _color_for_before: -> "1px 1px #{@blur}px rgba(0,0,0,#{@opacity})"

  # The CSS 'box-shadow' value for 'box:after'.
  #
  # Returns String.
  _color_for_after: -> "0 0 #{@blur}px rgba(0,0,0,#{@opacity})"

  # The CSS 'transform' value for 'box:before'.
  #
  # Returns String.
  _transform_for_before: ->
    tr = "translate(3px,8px)"
    sk = "skew(#{@skew}deg,#{@skew}deg)"
    "#{sk} #{tr}"

  # The CSS 'transform' value for 'box:after'.
  #
  # Returns String.
  _transform_for_after: ->
    tr = "translate(#{@xtranslate - 4}px,#{@ytranslate - 6}px)"
    sk = "skew(#{@skew}deg,#{@skew}deg)"
    "#{sk} #{tr}"

  # Get the CSS code for the '#box:before'.
  #
  # Returns String.
  code_for_box_before: ->
    tmp = @_transform_for_before()
    tr = @css_code_for_transform(tmp)
    ".box:before {\n
    z-index: -1;\n
    position: absolute;\n
    content: \"\";\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    bottom: #{@bottom}px;\n
    right: #{@right}px;\n
    background: #eee;\n
    border: 1px solid #ccc;\n
    box-shadow: #{@_color_for_before()};\n
    #{tr}
    }\n"

  # Get the CSS code for the '#box:after'.
  #
  # Returns String.
  code_for_box_after: ->
    tmp = @_transform_for_after()
    tr = @css_code_for_transform(tmp)
    ".box:after {\n
    z-index: -1;\n
    position: absolute;\n
    content: \"\";\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    bottom: #{@bottom}px;\n
    right: #{@right}px;\n
    background: #eee;\n
    border: 1px solid #ccc;\n
    box-shadow: #{@_color_for_after()};\n
    #{tr}
    }\n"

  # The SASS code value for 'box:before'.
  #
  # Returns String.
  sass_for_box_before: ->
    tmp = @_transform_for_before()
    tr = @sass_code_for_transform(tmp)
    ".box:before\n
  z-index: -1\n
  position: absolute\n
  content: \"\"\n
  width: #{@width}%\n
  height: #{@height}%\n
  bottom: #{@bottom}px\n
  right: #{@right}px\n
  background: #eee\n
  border: 1px solid #ccc\n
  box-shadow: #{@_color_for_before()}\n
  #{tr}\n"

  # The SASS code value for 'box:after'.
  #
  # Returns String.
  sass_for_box_after: ->
    tmp = @_transform_for_after()
    tr = @sass_code_for_transform(tmp)
    ".box:after\n
  z-index: -1\n
  position: absolute\n
  content: \"\"\n
  width: #{@width}%\n
  height: #{@height}%\n
  bottom: #{@bottom}px\n
  right: #{@right}px\n
  background: #eee\n
  border: 1px solid #ccc\n
  box-shadow: #{@_color_for_after()}\n
  #{tr}\n"
