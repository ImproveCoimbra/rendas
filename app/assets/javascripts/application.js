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

  // Load content on homepage map
  if ($('.home-map').size() > 0) {
    $.getScript('/load');
  }

  // Map loaded callback
  if (typeof Gmaps !== 'undefined' && typeof Gmaps.map !== 'undefined') {
    Gmaps.map.callback = function () {

      // Place markers if there are some waiting
      if (typeof markersToBeLoaded !== 'undefined') {
        Gmaps.map.replaceMarkers(markersToBeLoaded);
      }

      // Add Legend to MAP
      if (document.getElementById("map-legend") != null) {
        Gmaps.map.serviceObject.controls[google.maps.ControlPosition.BOTTOM_CENTER].push(document.getElementById("map-legend"));
      }

      // Hoods

      if ($('.hood').size() > 0) {
        $('.hood').each(function () {
          var hood = $(this);
          var hoodDiff = parseFloat(hood.data('hood-diff'));
          var hoodColor = '#EED500'; // Yellow
          if (hoodDiff > 0) {
            hoodColor = '#EE1100'; // Red
          } else if (hoodDiff < 0) {
            hoodColor = '#00CC00'; // Green
          }
          var circleOptions = {
            strokeWeight: 0,
            fillColor: hoodColor,
            fillOpacity: 0.3,
            map: Gmaps.map.map,
            center: new google.maps.LatLng(hood.data('hood-lat'), hood.data('hood-lng')),
            radius: hood.data('hood-radius')*100000,
            clickable: true,
          };
          // Add the circle for this city to the map.
          var hoodCircle = new google.maps.Circle(circleOptions);

          google.maps.event.addListener(hoodCircle, 'click', function() {
            var infoWindow = new google.maps.InfoWindow({
              content: '<h2 style="margin: 0; padding: 0;">'+hood.data('hood-name')+'</h2>'
            });
            infoWindow.setPosition(hoodCircle.getCenter());
            infoWindow.open(Gmaps.map.map);
          });
        });
      }

    };
  }

/*
  if ($('.hood').size() > 0) {
    $('.hood').each(function () {
      var hood = $(this);
      var map = Gmaps[$('.gmaps4rails_map', hood).attr('id')];
      map.callback = function () {
        var populationOptions = {
          strokeWeight: 0,
          fillColor: '#FF0000',
          fillOpacity: 0.1,
          map: this.map,
          center: new google.maps.LatLng(hood.data('hood-lat'), hood.data('hood-lng')),
          radius: hood.data('hood-radius')*100000
        };
        // Add the circle for this city to the map.
        cityCircle = new google.maps.Circle(populationOptions);
        //$(this).addOverlay(cityCircle);
      }
    });
  }
*/

});
