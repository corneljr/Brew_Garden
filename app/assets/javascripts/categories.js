$(document).on('ready page:load', function(){
	$('.sort').click( function(ev){
		ev.preventDefault();
		var text = ev.currentTarget.textContent;
		$.get('/projects/category/' + encodeURIComponent(text))
			.done( function(data){
				$('.category-container').html(data).fadeIn();
				$('.category-title').text(text).fadeIn();
				$('.category-count').text(window.project_count).css({'font-weight':'bold'});

				if ($('.progress-bar').length) progressDraw($('.progress-bar'));
			});
	});
});

