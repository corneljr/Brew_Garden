$(document).on('ready page:load', function(){
	$('#search-form').on('submit', function(event){
		event.preventDefault();
		var search = $('.search-input').val();

		$.get('/search?q=' + search)
			.done( function(data){
				$('.category-container').html(data)
			});
	});
});