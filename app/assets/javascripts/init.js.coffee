$(document).ready ->

  SSC.init()

  # Shadow properties that can be changed by user.
  properties = ['left', 'right', 'bottom', 'width', 'height', 'radius', 'distance', 'blur', 
                'xshift', 'yshift', 'opacity', 'skew', 'xorigin', 'yorigin', 'rotate']
  
  window.sheet_mgr = new window.StylesheetManager()
  window.box_tweaking = new window.BoxTweaking()
  window.maker = new window.ShadowMaker(properties)
  
  $('button').button({
    icons: { primary: "ui-icon-gear" }
  })
  
  
