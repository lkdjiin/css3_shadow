$(document).ready ->

  # Shadow properties that can be changed by user.
  properties = ['left', 'bottom', 'width', 'height', 'radius', 'distance', 'blur', 
                'xshift', 'yshift', 'opacity', 'skew', 'xorigin', 'yorigin']
  
  window.maker = new window.ShadowMaker(properties)
  window.box_tweaking = new window.BoxTweaking()
  
  $('button').button({
    icons: { primary: "ui-icon-gear" }
  })
  
  
