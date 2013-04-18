################################################################################
# Representing the state of a Wrinkled Shadow.
################################################################################
class window.WrinkledShadow extends window.BaseShadow

  # Create a simple shadow at top left.
  constructor: ->
    super()
    
    @width = 15
    @height = 15
    @left = 0
    @right = 0
    @top = 0
    @xshift = 10
    @yshift = 10
    @blur = 10
    @opacity = 0.5
    @rotate = 2
    @skew = 20
    @xtranslate = 14
    @ytranslate = 20
    @radius = 20

    @init()
    window.box_tweaking.set_radius(15,15,15,15,2,2,2,2)

  
  # value - Integer.
  set_left: (value) ->
    @left = value
    window.sheet_mgr.set SSC.AFTER, "left", "#{@left}%"
  
  # value - Integer.
  set_right: (value) ->
    @right = value
    window.sheet_mgr.set SSC.BEFORE, "right", "#{@right}%"
  
  # value - Integer.
  set_top: (value) ->
    @top = value
    window.sheet_mgr.set SSC.BEFORE, "top", "#{@top}%"
    window.sheet_mgr.set SSC.AFTER, "top", "#{@top}%"
  
  # value - Integer.
  set_radius: (value) ->
    @radius = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BORDER_RADIUS, "0 #{@radius}% 0 0"
    window.sheet_mgr.set SSC.AFTER, SSC.BORDER_RADIUS, "#{@radius}% 0 0 0"

  # value - Integer.
  set_blur: (value) ->
    @blur = value
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.BOX_SHADOW, @_color_for_after()
      
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
  set_opacity: (value) ->
    @opacity = value / 100
    window.sheet_mgr.set SSC.BEFORE, SSC.BOX_SHADOW, @_color_for_before()
    window.sheet_mgr.set SSC.AFTER, SSC.BOX_SHADOW, @_color_for_after()
  
  # Set the UI (sliders, etc.) to tweak the shadow.
  _setup_shadow_part: ->
    (@setup_part_sublayer() +
    @setup_part("Left", "left", @left) +
    @setup_part("Right", "right", @right) +
    @setup_part("Top", "top", @top) +
    @setup_part("Radius", "radius", @radius) +
    @setup_part("Color blur", "blur", @blur, 'px') +
    @setup_part("Color X shift", "xshift", @xshift, 'px') +
    @setup_part("Color Y shift", "yshift", @yshift, 'px') +
    @setup_part("Color opacity", "opacity", @opacity)
    )

  # Set callback methods (mostly on sliders) to know what to do when values
  # changed.
  _set_callbacks: ->
    @set_slider_callback("left", -50, 50, @left)
    @set_slider_callback("right", -50, 50, @right)
    @set_slider_callback("top", -50, 50, @top)
    @set_slider_callback("radius", 0, 50, @radius)
    @set_slider_callback("blur", 0, 50, @blur)
    @set_slider_callback("xshift", 0, 50, @xshift)
    @set_slider_callback("yshift", 0, 50, @yshift)
    @set_slider_callback("opacity", 0, 100, @opacity * 100)

  # Display a shadow on the box with default values.
  _display_default_shadow: ->
    window.sheet_mgr.delete_rules()
    after = "z-index: -1;
             left: #{@left}%;
             top: #{@top}%;
             width: #{@width}%;
             height: #{@height}%;
             #{SSC.CSS_BORDER_RADIUS}: #{@radius}% 0 0 0;
             #{SSC.CSS_BOX_SHADOW}: -#{@xshift}px -#{@yshift}px #{@blur}px
                                     rgba(0,0,0,#{@opacity});
             #{SSC.CSS_TRANSFORM}: rotate(#{@rotate}deg)
                                   translate(#{@xtranslate}px,#{@ytranslate}px)
                                   skew(#{@skew}deg);"

    before = "z-index: -1;
             right: #{@right}%;
             top: #{@top}%;
             width: #{@width}%;
             height: #{@height}%;
             #{SSC.CSS_BORDER_RADIUS}: 0 #{@radius}% 0 0;
             #{SSC.CSS_BOX_SHADOW}: #{@xshift}px -#{@yshift}px #{@blur}px
                                     rgba(0,0,0,#{@opacity});
             #{SSC.CSS_TRANSFORM}: rotate(#{@rotate}deg)
                                   translate(-#{@xtranslate}px,#{@ytranslate}px)
                                   skew(-#{@skew}deg);"
    window.sheet_mgr.insert_after_and_before_rules after, before

  # The CSS 'box-shadow' value for 'box:after'.
  #
  # Returns String.
  # TODO this should be in parent
  _color_for_after: ->
    "-#{@xshift}px -#{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"

  # The CSS 'box-shadow' value for 'box:before'.
  #
  # Returns String.
  # TODO this should be in parent
  _color_for_before: ->
    "#{@xshift}px -#{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"

  # The CSS 'transform' value for 'box:before'.
  #
  # Returns String.
  _transform_for_before: ->
    ro = "rotate(#{@rotate}deg)"
    tr = "translate(-#{@xtranslate}px,#{@ytranslate}px)"
    sk = "skew(-#{@skew}deg)"
    "#{ro} #{tr} #{sk}"

  # The CSS 'transform' value for 'box:after'.
  #
  # Returns String.
  _transform_for_after: ->
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
    right: #{@right}px;\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    border-radius: 0 #{@radius}% 0 0;\n
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
  right: #{@right}px\n
  width: #{@width}%\n
  height: #{@height}%\n
  border-radius: 0 #{@radius}% 0 0\n
  box-shadow: #{@_color_for_before()}\n
  #{tr}\n"

  # Get the CSS code fot the '#box:after'.
  #
  # Returns String.
  code_for_box_after: ->
    tmp = @_transform_for_after()
    tr = @css_code_for_transform(tmp)
    ".box:after {\n
    position: absolute;\n
    z-index: -1;\n
    content: \"\";\n
    top: #{@top}px;\n
    left: #{@right}px;\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    border-radius: #{@radius}% 0 0 0;\n
    box-shadow: #{@_color_for_after()};\n
    #{tr}
    }\n"

  # Get the SASS code fot the '#box:after'.
  #
  # Returns String.
  sass_for_box_after: ->
    tmp = @_transform_for_after()
    tr = @sass_code_for_transform(tmp)
    ".box:after\n
  position: absolute\n
  z-index: -1\n
  content: \"\"\n
  top: #{@top}px\n
  left: #{@right}px\n
  width: #{@width}%\n
  height: #{@height}%\n
  border-radius: #{@radius}% 0 0 0\n
  box-shadow: #{@_color_for_after()}\n
  #{tr}\n"

