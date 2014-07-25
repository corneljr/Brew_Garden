$(document).on('ready page:load', function() {

    var map = L.mapbox.map('map2', 'dhurley99.ipn4bc66').setView([43.652, -79.382], 13);

    $.ajax( {
      url: '/projects',
      dataType: 'json',
      type: 'GET',

    }).done(function(data) {
        map.featureLayer.setGeoJSON(data);
    });

   map.scrollWheelZoom.disable();
		
});