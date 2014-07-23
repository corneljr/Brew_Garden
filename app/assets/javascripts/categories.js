$(document).on('ready page:load', function(){
	$('.sort').click( function(ev){
		ev.preventDefault();
		var text = ev.currentTarget.textContent;
		$.get('/projects/category/' + encodeURIComponent(text))
			.done( function(data){
				$('.category-container').html(data).fadeIn();
			});
	});
});