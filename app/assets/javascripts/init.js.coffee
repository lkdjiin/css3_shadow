
$(document).ready ->
  window.maker = new window.ShadowMaker()
  window.box_tweaking = new window.BoxTweaking()
  $('button').button({
    icons: { primary: "ui-icon-gear" }
  })
