$(document).ready( function() {
	$('.project-info-link-item').on('click', function(ev){
		ev.preventDefault();
		var text = ev.currentTarget.textContent
		if (text === 'home'){
			text = '';
		}

		$.get(window.location.pathname + '/' + text)
			.done(function(data){
				$('.project-container').html(data)
			});
	});
});