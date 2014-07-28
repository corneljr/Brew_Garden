$(document).ready( function(){
	$('input').on('input click', function(){
		$('.save').removeAttr('disabled')
		$('.post').attr('disabled','disabled')
  });	
});
 