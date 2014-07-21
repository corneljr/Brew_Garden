$(document).on('ready page:load', function(){
	navigator.geolocation.getCurrentPosition(geolocationSuccess) 
});

function geolocationSuccess(position) {
	var latitude = position.coords.latitude;
	var longitude = position.coords.longitude;
	console.log(latitude)
	console.log(longitude)

	$.ajax({
		url: '/projects',
		method: 'GET', 
		data: {
			latitude: latitude,
			longitude: longitude,
		}, 
		dataType: 'script'
	});
}