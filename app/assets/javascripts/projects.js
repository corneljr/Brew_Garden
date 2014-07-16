$(document).ready(function() {
	// initalize for mapbox
	var map = L.mapbox.map('map', 'dhurley99.ipn4bc66').setView([43.652, -79.396], 12);
	var longitude = $('#map').data('long');
	var latitude = $('#map').data('lat');
	var title = $('#map').data('title');
	var description = $('#map').data('description');
	// add pin to project show page
	L.mapbox.featureLayer({
	    // this feature is in the GeoJSON format: see geojson.org
	    // for the full specification
	    type: 'Feature',
	    geometry: {
	        type: 'Point',
	        // coordinates here are in longitude, latitude order because
	        // x, y is the standard for GeoJSON and many formats
	        coordinates: [
	          longitude,
	          latitude 
	        ]
	    },
	    properties: {
	        title: title,
	        description: description,
	        // one can customize markers by adding simplestyle properties
	        // https://www.mapbox.com/foundations/an-open-platform/#simplestyle
	        'marker-size': 'large',
	        'marker-color': '#BE9A6B',
	        'marker-symbol': 'beer'
	    }
	}).addTo(map);

	$('.sort').on('click', function(ev){
		ev.preventDefault();
		var text = ev.currentTarget.textContent

		$.ajax({
			type: 'GET',
			url: '/projects',
			dataType: 'script',
			data: {type: text}
		});
	});

});