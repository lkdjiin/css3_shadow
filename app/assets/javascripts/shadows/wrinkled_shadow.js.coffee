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
    @opacity = 0.2
    @rotate = 2
    @skew = 20
    @xtranslate = 14
    @ytranslate = 20

    @init()
    window.box_tweaking.set_radius(15,15,15,15,2,2,2,2)

  # value - Integer.
  set_width: (value) ->
    @width = value
    window.sheet_mgr.set SSC.BEFORE, "width", "#{@width}%"
    window.sheet_mgr.set SSC.AFTER, "width", "#{@width}%"
  
  # value - Integer.
  set_height: (value) ->
    @height = value
    window.sheet_mgr.set SSC.BEFORE, "height", "#{@height}%"
    window.sheet_mgr.set SSC.AFTER, "height", "#{@height}%"
  
  # Set the UI (sliders, etc.) to tweak the shadow.
  _setup_shadow_part: ->
    (@setup_part_sublayer() +
    @setup_part("Width", "width", @width) +
    @setup_part("Height", "height", @height)
    )

  # Set callback methods (mostly on sliders) to know what to do when values
  # changed.
  _set_callbacks: ->
    @set_slider_callback("width", 0, 100, @width)
    @set_slider_callback("height", 0, 100, @height)

  # Display a shadow on the box with default values.
  _display_default_shadow: ->
    window.sheet_mgr.delete_rules()
    after = "z-index: -1;
             left: #{@left}%;
             top: #{@top}%;
             width: #{@width}%;
             height: #{@height}%;
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
             #{SSC.CSS_BOX_SHADOW}: #{@xshift}px -#{@yshift}px #{@blur}px
                                     rgba(0,0,0,#{@opacity});
             #{SSC.CSS_TRANSFORM}: rotate(#{@rotate}deg)
                                   translate(-#{@xtranslate}px,#{@ytranslate}px)
                                   skew(-#{@skew}deg);"
    window.sheet_mgr.insert_after_and_before_rules after, before

