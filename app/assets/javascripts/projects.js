$(document).ready(function() {
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