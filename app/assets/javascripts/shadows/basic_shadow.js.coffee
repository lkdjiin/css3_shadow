################################################################################
# Representing the state of a Basic Shadow.
################################################################################
class window.BasicShadow extends window.BaseShadow

  # Create a simple shadow at top left.
  constructor: ->
    super()

    @top = 0
    @left = 0
    @width = 33
    @height =  25
    @xshift = 10
    @yshift = 10
    @blur = 15
    @opacity = 0.5
    @rotate = 7
    @skew = 20
    @xtranslate = 20
    @ytranslate = 25

    @init()
    window.box_tweaking.set_radius(2,0,0,0,20,0,0,0)

  # value - Integer.
  set_width: (value) ->
    @width = value
    window.sheet_mgr.set SSC.BEFORE, "width", "#{@width}%"

  # value - Integer.
  set_height: (value) ->
    @height = value
    window.sheet_mgr.set SSC.BEFORE, "height", "#{@height}%"

  # value - Integer.
  set_top: (value) ->
    @top = value
    window.sheet_mgr.set SSC.BEFORE, "top", "#{@top}%"

  # value - Integer.
  set_left: (value) ->
    @left = value
    window.sheet_mgr.set SSC.BEFORE, "left", "#{@left}%"

  # value - Integer.
  set_blur: (value) ->
    @blur = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()

  # value - Integer.
  set_xshift: (value) ->
    @xshift = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()

  # value - Integer.
  set_yshift: (value) ->
    @yshift = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()

  # value - Integer.
  set_opacity: (value) ->
    @opacity = value / 100
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()

  # value - Integer.
  set_skew: (value) ->
    @skew = value
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM, @_transform_for_before()

  # value - Integer.
  set_rotate: (value) ->
    @rotate = value
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM, @_transform_for_before()

  # value - Integer.
  set_xtranslate: (value) ->
    @xtranslate = value
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM, @_transform_for_before()

  # value - Integer.
  set_ytranslate: (value) ->
    @ytranslate = value
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM, @_transform_for_before()

  # Set the UI (sliders, etc.) to tweak the shadow.
  _setup_shadow_part: ->
    (@setup_part_sublayer() +
    @setup_part("Width", "width", @width) +
    @setup_part("Height", "height", @height) +
    @setup_part("Top", "top", @top) +
    @setup_part("Left", "left", @left) +
    @setup_part("Color blur", "blur", @blur, 'px') +
    @setup_part("Color X shift", "xshift", @xshift, 'px') +
    @setup_part("Color Y shift", "yshift", @yshift, 'px') +
    @setup_part("Color opacity", "opacity", @opacity) +
    @setup_part("Skew", "skew", @skew, 'deg') +
    @setup_part("Rotate", "rotate", @rotate, 'deg') +
    @setup_part("X translate", "xtranslate", @xtranslate, 'px') +
    @setup_part("Y translate", "ytranslate", @ytranslate, 'px')
    )

  # Set callback methods (mostly on sliders) to know what to do when values
  # changed.
  _set_callbacks: ->
    @set_slider_callback("width", 0, 100, @width)
    @set_slider_callback("height", 0, 100, @height)
    @set_slider_callback("top", -50, 50, @top)
    @set_slider_callback("left", -50, 50, @left)
    @set_slider_callback("blur", 0, 50, @blur)
    @set_slider_callback("xshift", 0, 50, @xshift)
    @set_slider_callback("yshift", 0, 50, @yshift)
    @set_slider_callback("opacity", 0, 100, @opacity * 100)
    @set_slider_callback("skew", 0, 90, @skew)
    @set_slider_callback("rotate", 0, 90, @rotate)
    @set_slider_callback("xtranslate", 0, 50, @xtranslate)
    @set_slider_callback("ytranslate", 0, 50, @ytranslate)

  # Display a shadow on the box with default values.
  _display_default_shadow: ->
    window.sheet_mgr.delete_rules()
    after = "z-index: -1;"
    before = "#{SSC.CSS_BOX_SHADOW}: -#{@xshift}px -#{@yshift}px #{@blur}px
                                     rgba(0,0,0,#{@opacity});
             #{SSC.CSS_TRANSFORM}: rotate(#{@rotate}deg)
                                   translate(#{@xtranslate}px,#{@ytranslate}px)
                                   skew(#{@skew}deg);
             z-index: -1;
             left: #{@left}%;
             top: #{@top}%;
             width: #{@width}%;
             height: #{@height}%;"
    window.sheet_mgr.insert_after_and_before_rules after, before

  # The CSS 'box-shadow' value for 'box:before'.
  #
  # Returns String.
  # TODO this should be in parent
  _color_for_before: ->
    "-#{@xshift}px -#{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"

  # The CSS 'transform' value for 'box:before'.
  #
  # Returns String.
  _transform_for_before: ->
    ro = "rotate(#{@rotate}deg)"
    tr = "translate(#{@xtranslate}px,#{@ytranslate}px)"
    sk = "skew(#{@skew}deg)"
    "#{ro} #{tr} #{sk}"

  # Get the CSS code fot the '#box:before'.
  #
  # Returns String.
  code_for_box_before: ->
    tmp = @_transform_for_before()
    tr = @css_code_for_transform(tmp)
    ".box:before {\n
    position: absolute;\n
    z-index: -1;\n
    content: \"\";\n
    top: #{@top}px;\n
    left: #{@left}px;\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    box-shadow: #{@_color_for_before()};\n
    #{tr}
    }\n"

  # Get the SASS code fot the '#box:before'.
  #
  # Returns String.
  sass_for_box_before: ->
    tmp = @_transform_for_before()
    tr = @sass_code_for_transform(tmp)
    ".box:before\n
  position: absolute\n
  z-index: -1\n
  content: \"\"\n
  top: #{@top}px\n
  left: #{@left}px\n
  width: #{@width}%\n
  height: #{@height}%\n
  box-shadow: #{@_color_for_before()}\n
  #{tr}\n"

  # The CSS 'box-shadow' value for 'box:after'.
  #
  # Returns String.
  code_for_box_after: -> ""

  # The SASS 'box-shadow' value for 'box:after'.
  #
  # Returns String.
  sass_for_box_after: -> ""
