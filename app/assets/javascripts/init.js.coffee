$(document).ready ->

  # Shadow properties that can be changed by user.
  properties = ['left', 'right', 'bottom', 'width', 'height', 'radius', 'distance', 'blur', 
                'xshift', 'yshift', 'opacity', 'skew', 'xorigin', 'yorigin']
  
  window.sheet_mgr = new window.StylesheetManager()
  window.maker = new window.ShadowMaker(properties)
  window.box_tweaking = new window.BoxTweaking()
  
  $('button').button({
    icons: { primary: "ui-icon-gear" }
  })
  
  
