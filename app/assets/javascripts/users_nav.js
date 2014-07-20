$(document).ready( function(){
	$('.user-link').eq(0).css('font-weight', 'bold');

	$('.user-link').on('click', function(ev){
		ev.preventDefault();
		var item = ev.currentTarget.textContent.toLowerCase();
		$('.user-link').css('font-weight', 'normal');
		$(this).css('font-weight', 'bold');

		$.get(window.location.pathname + '/' + item)
			.done( function(data){
				$('.user-project-info').html(data)
			});
	});
});