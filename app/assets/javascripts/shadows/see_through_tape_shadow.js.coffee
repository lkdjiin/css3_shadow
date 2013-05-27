########################################################################
# The state of a See Through Tape Shadow.
########################################################################
class window.SeeThroughTapeShadow extends window.BaseShadow

  constructor: ->
    super()

    @width = 130
    @height = 30
    @xshift = 0
    @yshift = 0
    @blur = 3
    @opacity = 0.15
    @xtranslate = 44
    @ytranslate = 10
    @rotate = -45
    @skew = 0

    @init()
    window.box_tweaking.set_default()

  # value - Integer.
  set_width: (value) ->
    @width = value
    window.sheet_mgr.set SSC.BEFORE, "width", "#{value}px"
    window.sheet_mgr.set SSC.AFTER, "width", "#{value}px"
  
  # value - Integer.
  set_height: (value) ->
    @height = value
    window.sheet_mgr.set SSC.BEFORE, "height", "#{value}px"
    window.sheet_mgr.set SSC.AFTER, "height", "#{value}px"
  
  # value - Integer.
  set_xshift: (value) ->
    @xshift = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.BOX_SHADOW, @_color_for_after()
  
  # value - Integer.
  set_yshift: (value) ->
    @yshift = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.BOX_SHADOW, @_color_for_after()
  
  # value - Integer.
  set_blur: (value) ->
    @blur = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.BOX_SHADOW, @_color_for_after()
  
  # value - Integer.
  set_opacity: (value) ->
    @opacity = value / 100
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.BOX_SHADOW, @_color_for_after()
  
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

  # value - Integer.
  set_rotate: (value) ->
    @rotate = value
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM, @_transform_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.TRANSFORM, @_transform_for_after()

  # value - Integer.
  set_skew: (value) ->
    @skew = value
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM, @_transform_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.TRANSFORM, @_transform_for_after()

  # Set the UI (sliders, etc.) to tweak the shadow.
  _setup_shadow_part: ->
    (@setup_part("Width", "width", @width, 'px') +
    @setup_part("Height", "height", @height, 'px') +
    @setup_part("Color Y shift", "yshift", @yshift, 'px') +
    @setup_part("Color X shift", "xshift", @xshift, 'px') +
    @setup_part("Color blur", "blur", @blur, 'px') +
    @setup_part("Color opacity", "opacity", @opacity) +
    @setup_part("Rotate", "rotate", @rotate, 'deg') +
    @setup_part("Skew", "skew", @skew, 'deg') +
    @setup_part("X translate", "xtranslate", @xtranslate, 'px') +
    @setup_part("Y translate", "ytranslate", @ytranslate, 'px'))

  # Set callback methods (mostly on sliders) to know what to do when values
  # changed.
  _set_callbacks: ->
    @set_slider_callback("width", 10, 200, @width)
    @set_slider_callback("height", 10, 100, @height)
    @set_slider_callback("yshift", -20, 20, @yshift)
    @set_slider_callback("xshift", -20, 20, @xshift)
    @set_slider_callback("blur", 0, 20, @blur)
    @set_slider_callback("opacity", 0, 100, @opacity * 100)
    @set_slider_callback("xtranslate", -100, 100, @xtranslate)
    @set_slider_callback("ytranslate", -100, 100, @ytranslate)
    @set_slider_callback("rotate", -359, 0, @rotate)
    @set_slider_callback("skew", -30, 30, @skew)

  # Display a shadow on the box with default values.
  _display_default_shadow: ->
    window.sheet_mgr.delete_rules()
    after = "width: #{@width}px;
      height: #{@height}px;
      border-left: 1px dashed rgba(0, 0, 0, 0.1);
      border-right: 1px dashed rgba(0, 0, 0, 0.1);
      background: rgba(0, 0, 0, 0.1);
      background: -webkit-gradient(linear, 555% 20%, 0% 92%, from(rgba(0, 0, 0, 0.1)), to(rgba(0, 0, 0, 0.0)), color-stop(.1,rgba(0, 0, 0, 0.2)));
      background: -moz-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));
      background: -ms-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));
      background: -o-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));
      background: linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));
      #{SSC.CSS_BOX_SHADOW}: #{@xshift}px #{@yshift}px #{@blur}px rgba(0, 0, 0, #{@opacity});
      #{SSC.CSS_TRANSFORM}: translate(-44px,10px)
                            skew(0deg)
                            rotate(#{@rotate}deg);
             "
    before = "right: 0;
      bottom: 0;
      width: #{@width}px;
      height: #{@height}px;
      background: rgba(0, 0, 0, 0.1);
      background: -webkit-gradient(linear, 555% 20%, 0% 92%, from(rgba(0, 0, 0, 0.1)), to(rgba(0, 0, 0, 0.0)), color-stop(.1,rgba(0, 0, 0, 0.2)));
      background: -moz-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));
      background: -ms-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));
      background: -o-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));
      background: linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));
      border-left: 1px dashed rgba(0, 0, 0, 0.1);
      border-right: 1px dashed rgba(0, 0, 0, 0.1);
      #{SSC.CSS_BOX_SHADOW}: #{@xshift}px #{@yshift}px #{@blur}px rgba(0, 0, 0, #{@opacity});
      #{SSC.CSS_TRANSFORM}: translate(44px,-10px)
                            skew(0deg)
                            rotate(#{@rotate}deg);
      "
    window.sheet_mgr.insert_after_and_before_rules after, before


  # The CSS 'box-shadow' value for 'box:before'.
  #
  # Returns String.
  _color_for_before: -> "#{@xshift}px #{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"

  # The CSS 'box-shadow' value for 'box:after'.
  #
  # Returns String.
  _color_for_after: -> "#{@xshift}px #{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"

  # The CSS 'transform' value for 'box:before'.
  #
  # Returns String.
  _transform_for_before: ->
    ro = "rotate(#{@rotate}deg)"
    tr = "translate(#{@xtranslate}px,#{-@ytranslate}px)"
    sk = "skew(#{@skew}deg)"
    "#{tr} #{sk} #{ro}"

  # The CSS 'transform' value for 'box:after'.
  #
  # Returns String.
  _transform_for_after: ->
    ro = "rotate(#{@rotate}deg)"
    tr = "translate(#{-@xtranslate}px,#{@ytranslate}px)"
    sk = "skew(#{@skew}deg)"
    "#{tr} #{sk} #{ro}"

  # Get the CSS code for the '#box:before'.
  #
  # Returns String.
  code_for_box_before: ->
    tmp = @_transform_for_before()
    tr = @css_code_for_transform(tmp)
    ".box:before {\n
    position: absolute;\n
    content: \"\";\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    border-left: 1px dashed rgba(0, 0, 0, 0.1);\n
    border-right: 1px dashed rgba(0, 0, 0, 0.1);\n
    background: rgba(0, 0, 0, 0.1);\n
    background: -webkit-gradient(linear, 555% 20%, 0% 92%, from(rgba(0, 0, 0, 0.1)), to(rgba(0, 0, 0, 0.0)), color-stop(.1,rgba(0, 0, 0, 0.2)));\n
    background: -moz-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));\n
    background: -ms-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));\n
    background: -o-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));\n
    background: linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));\n
    box-shadow: #{@_color_for_before()};\n
    #{tr}
    }\n"

  # Get the CSS code for the '#box:after'.
  #
  # Returns String.
  code_for_box_after: ->
    tmp = @_transform_for_after()
    tr = @css_code_for_transform(tmp)
    ".box:before {\n
    position: absolute;\n
    content: \"\";\n
    right: 0;\n
    left: 0;\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    border-left: 1px dashed rgba(0, 0, 0, 0.1);\n
    border-right: 1px dashed rgba(0, 0, 0, 0.1);\n
    background: rgba(0, 0, 0, 0.1);\n
    background: -webkit-gradient(linear, 555% 20%, 0% 92%, from(rgba(0, 0, 0, 0.1)), to(rgba(0, 0, 0, 0.0)), color-stop(.1,rgba(0, 0, 0, 0.2)));\n
    background: -moz-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));\n
    background: -ms-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));\n
    background: -o-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));\n
    background: linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0));\n
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
  position: absolute\n
  content: \"\"\n
  width: #{@width}%\n
  height: #{@height}%\n
  border-left: 1px dashed rgba(0, 0, 0, 0.1)\n
  border-right: 1px dashed rgba(0, 0, 0, 0.1)\n
  background: rgba(0, 0, 0, 0.1)\n
  background: -webkit-gradient(linear, 555% 20%, 0% 92%, from(rgba(0, 0, 0, 0.1)), to(rgba(0, 0, 0, 0.0)), color-stop(.1,rgba(0, 0, 0, 0.2)))\n
  background: -moz-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0))\n
  background: -ms-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0))\n
  background: -o-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0))\n
  background: linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0))\n
  box-shadow: #{@_color_for_before()}\n
  #{tr}\n"

  # The SASS code value for 'box:after'.
  #
  # Returns String.
  sass_for_box_after: ->
    tmp = @_transform_for_after()
    tr = @sass_code_for_transform(tmp)
    ".box:after\n
  position: absolute\n
  content: \"\"\n
  right: 0\n
  left: 0\n
  width: #{@width}%\n
  height: #{@height}%\n
  border-left: 1px dashed rgba(0, 0, 0, 0.1)\n
  border-right: 1px dashed rgba(0, 0, 0, 0.1)\n
  background: rgba(0, 0, 0, 0.1)\n
  background: -webkit-gradient(linear, 555% 20%, 0% 92%, from(rgba(0, 0, 0, 0.1)), to(rgba(0, 0, 0, 0.0)), color-stop(.1,rgba(0, 0, 0, 0.2)))\n
  background: -moz-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0))\n
  background: -ms-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0))\n
  background: -o-linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0))\n
  background: linear-gradient(555% 0 180deg, rgba(0,0,0,0.1), rgba(0,0,0,0.2) 10%, rgba(0,0,0,0.0))\n
  box-shadow: #{@_color_for_after()}\n
  #{tr}\n"
