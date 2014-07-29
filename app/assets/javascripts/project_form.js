$(document).ready( function(){
	$('input').on('input click', function(){
		$('.save').removeAttr('disabled')
		$('.post').attr('disabled','disabled')
  });	
	// Update project title in realtime 
  var title = $('#project_title').val();
  $('.preview-title h1').text(title)

  var shortBlurb = $('#project_short_blurb').val();
  $('.preview-description p').text(shortBlurb);


	$('#project_title').bind('input', function() {
			$('.preview-title h1').text($(this).val());
	});
	// Update project description in realtime
	$('#project_short_blurb').bind('input', function() {
			$('.preview-description p').text($(this).val());
	});

  $('#project_days_left').bind('input', function() {
        $('.days-left').text($(this).val());
  });

  $('.helper-msg').on('input', 'input', function() {
  	$(this).parent('.helper-msg').find('.helpers').animate({ 'opacity':'0.8'}, 800);
  });
  $('.helper-msg').on('input', 'textarea', function() {
  	$(this).parent('.helper-msg').find('.helpers').animate({ 'opacity':'0.8'}, 800);
  });

  $('iframe').on('input', function() {
  			alert('what');
  });

  $(".logo-input").change(function(){
    readURL(this);
  });

});
 


function readURL(input) {

  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#blah').attr('src', e.target.result);
    }

    reader.readAsDataURL(input.files[0]);
  }
}

