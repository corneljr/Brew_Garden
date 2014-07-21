$(document).on('ready page:load', function(){
	$('.change-location').on('click', function(ev){
		ev.preventDefault();
		$('.location-search').show();
		$('.location-header').hide();
	});

	$('.location-form').submit( function(event){
		event.preventDefault();
		var search = $('.location-input').val();

		$.ajax({
			url: '/projects/location_search',
			type: 'GET',
			dataType: 'html',
			data: search
		}).done(function(data){

			});
	});
});