$(document).ready( function(){
	$('input').on('input', function(){
		$('.save').removeAttr('disabled')
		$('.post').attr('disabled','disabled')
  });	
});
 