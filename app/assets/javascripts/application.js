// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jss
//= require_tree .

$(document).ready(function() {
  $("#slider_width").slider({
    range: "min",
    min: 50,
    max: 100,
    value: 80,
    slide: function(event, ui) {
        $("#value_width").html(ui.value);
        //alert($("#box").css("color"));
//        $("#box:before").css('borderTopLeftRadius', ui.value + "px");
        //document.getElementById('box').style.width = ui.value + "%";
        jss('#box:before', {
            width: ui.value + '%'
        });
      }
  });
});
