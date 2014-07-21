$(document).ready( function(){
	navigator.geolocation.getCurrentPosition(geolocationSuccess) 
});

function geolocationSuccess(position) {
	var latitude = position.coords.latitude;
	var longitude = position.coords.longitude;
}