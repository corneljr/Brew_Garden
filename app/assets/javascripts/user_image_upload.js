$(document).ready( function(){
	$('.avatar-upload').change(function(){
		readImgURL(this);
	})
});

function readImgURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();

		reader.onload = function(e) {
			$('.profile-picture').attr('src', e.target.result);
		}

		reader.readAsDataURL(input.files[0])
	}
}
