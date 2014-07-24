$(document).on('ready page:load', function() {

		var longitude = $('#map2').data('long');
    var latitude = $('#map2').data('lat');

    var map = L.mapbox.map('map2', 'dhurley99.ipn4bc66').setView([latitude, longitude], 13);
    $.ajax( {
      url: '/projects',
      dataType: 'json',
      type: 'GET',

    }).done(function(data) {
        map.featureLayer.setGeoJSON(data);
    });

   map.scrollWheelZoom.disable();
		
});