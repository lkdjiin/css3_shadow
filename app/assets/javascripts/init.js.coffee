$(document).ready ->

  SSC.init()

  # Shadow properties that can be changed by user.
  properties = ['left', 'right', 'top', 'bottom', 'width', 'height', 'radius',
                'distance', 'blur', 'xshift', 'yshift', 'opacity', 'skew',
                'xorigin', 'yorigin', 'rotate', 'xtranslate', 'ytranslate']
  
  window.sheet_mgr = new window.StylesheetManager()
  window.box_tweaking = new window.BoxTweaking()
  window.maker = new window.ShadowMaker(properties)
  
  $('button').button()

  $('#tabs').tabs()
  
  
