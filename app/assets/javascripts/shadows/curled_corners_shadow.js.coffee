################################################################################
# Representing the state of a curled corners Shadow.
################################################################################
class window.CurledCornersShadow extends window.BaseShadow

  constructor: ->
    super()
    
    @bottom = 15
    @left = 10
    @right = 10
    @width = 50
    @height = 20
    @yshift = 15
    @blur = 10
    @opacity = 0.7
    @rotate = 3
    @skew = 0
    
    @init()
    $('#box').css({ borderRadius: "0 0 25% 25% / 0 0 3% 3%" })
  
  # value - Integer.
  set_bottom: (value) ->
    @bottom = value
    window.sheet_mgr.set SSC.BEFORE, "bottom", "#{value}px"
    window.sheet_mgr.set SSC.AFTER, "bottom", "#{value}px"
  
  # value - Integer.
  set_distance: (value) ->
    @left = @right = value
    window.sheet_mgr.set SSC.BEFORE, "left", "#{value}px"
    window.sheet_mgr.set SSC.AFTER, "right", "#{value}px"
  
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
  set_rotate: (value) ->
    @rotate = value
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM, "rotate(-#{value}deg) skew(-#{@skew}deg)"
    window.sheet_mgr.set SSC.AFTER, SSC.TRANSFORM, "rotate(#{value}deg) skew(#{@skew}deg)"
  
  # value - Integer.
  set_skew: (value) ->
    @skew = value
    window.sheet_mgr.set SSC.BEFORE, SSC.TRANSFORM, "rotate(-#{@rotate}deg) skew(-#{@skew}deg)"
    window.sheet_mgr.set SSC.AFTER, SSC.TRANSFORM, "rotate(#{@rotate}deg) skew(#{@skew}deg)"
    
  # Set the UI (sliders, etc.) to tweak the shadow.
  _setup_shadow_part: ->
    (@setup_part_sublayer() +
    @setup_part("Bottom", "bottom", @bottom, 'px') +
    @setup_part("Distance", "distance", @left, 'px') +
    @setup_part("Width", "width", @width, '%') +
    @setup_part("Height", "height", @height, '%') +
    @setup_part("Color Y shift", "yshift", @yshift) +
    @setup_part("Color blur", "blur", @blur) +
    @setup_part("Color opacity", "opacity", @opacity) +
    @setup_part("Rotate", "rotate", @rotate, 'deg') +
    @setup_part("Skew", "skew", @skew, 'deg'))
    
  # Set callback methods (mostly on sliders) to know what to do when values
  # changed.
  _set_callbacks: ->
    @set_slider_callback("bottom", 0, 100, @bottom)
    @set_slider_callback("distance", 0, 100, @left)
    @set_slider_callback("width", 10, 100, @width)
    @set_slider_callback("height", 5, 100, @height)
    @set_slider_callback("yshift", 0, 50, @yshift)
    @set_slider_callback("blur", 0, 50, @blur)
    @set_slider_callback("opacity", 0, 100, @opacity * 100)
    @set_slider_callback("rotate", 0, 30, @rotate)
    @set_slider_callback("skew", 0, 50, @skew)
  
  # Display a shadow on the box with default values.
  _display_default_shadow: ->
    window.sheet_mgr.delete_rules()
    after = "z-index: -1;
             bottom: #{@bottom}px;
             right: #{@right}px;
             width: #{@width}%;
             height: #{@height}%;
             #{SSC.CSS_BOX_SHADOW}: 0 #{@yshift}px #{@blur}px rgba(0, 0, 0, #{@opacity});
             #{SSC.CSS_TRANSFORM}: rotate(3deg) skew(0deg);
             "
    before = "z-index: -1;
              bottom: #{@bottom}px;
              left: #{@left}px;
              width: #{@width}%;
              height: #{@height}%;
              #{SSC.CSS_BOX_SHADOW}: 0 #{@yshift}px #{@blur}px rgba(0, 0, 0, #{@opacity});
              #{SSC.CSS_TRANSFORM}: rotate(-3deg) skew(0deg);
              "
    window.sheet_mgr.insert_after_and_before_rules after, before
    
  # The CSS 'box-shadow' value for 'box:before'.
  #
  # Returns String.
  _color_for_before: -> "0 #{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"
    
  # The CSS 'box-shadow' value for 'box:after'.
  #
  # Returns String.
  _color_for_after: -> "0 #{@yshift}px #{@blur}px rgba(0,0,0,#{@opacity})"
  
  # Get the CSS code fot the '#box:before'.
  #
  # Returns String.
  code_for_box_before: ->
    "#box:before {\n
    z-index: -1;\n
    bottom: #{@bottom}px;\n
    left: #{@left}px;\n
    width: #{@width}%;\n
    height: #{@height}%;\n
    #{SSC.CSS_BOX_SHADOW}: 0 #{@yshift}px #{@blur}px rgba(0, 0, 0, #{@opacity});\n
    #{SSC.CSS_TRANSFORM}: rotate(-#{@rotate}deg) skew(-#{@skew}deg);\n
    }\n"
              
  # Get the CSS code fot the '#box:after'.
  #
  # Returns String.
  code_for_box_after: ->
    "#box:after {\n
     z-index: -1;\n
     bottom: #{@bottom}px;\n
     right: #{@right}px;\n
     width: #{@width}%;\n
     height: #{@height}%;\n
     #{SSC.CSS_BOX_SHADOW}: 0 #{@yshift}px #{@blur}px rgba(0, 0, 0, #{@opacity});\n
     #{SSC.CSS_TRANSFORM}: rotate(#{@rotate}deg) skew(#{@skew}deg);\n
     }\n"
