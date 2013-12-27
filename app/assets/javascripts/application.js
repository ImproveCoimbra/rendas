// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require nvd3/d3.v3
//= require nvd3/nv.d3
//= require underscore
//= require_tree .

$(function() {

  if ($('.home-map').size() > 0) {
    $.getScript('/load');
  }

  // Add Legend to MAP
  if (typeof Gmaps !== 'undefined') {
    Gmaps.map.callback = function () {
      if (document.getElementById("map-legend") != null) {
        Gmaps.map.serviceObject.controls[google.maps.ControlPosition.BOTTOM_CENTER].push(document.getElementById("map-legend"));
      }
    };
  }

});
