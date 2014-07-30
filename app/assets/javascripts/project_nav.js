$(document).ready( function() {
	$('.project-info-link-item').on('click', function(ev){
		ev.preventDefault();
		$('.project-info-link-item').parent().removeClass('hnav-on');
		 $(this).parent().addClass('hnav-on');

		var text = ev.currentTarget.textContent
		var attr = text.split(" ")[0];


		if (text === 'home'){
			attr = '';
		}

		$.get(window.location.pathname + '/' + attr)
			.done(function(data){
				$('.project-container').html(data)
				$('.slider').slick();
			});
	});
	$('.slider-project').slick({
    dots: true,
    speed: 500,
    autoplay: false
  });
});