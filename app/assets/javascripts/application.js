// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// require turbolinks // not using turbolinks for this project
// require foundation // This is the entire foundation core, definitely not needed.
//
//= require jquery
//= require jquery_ujs
//= require ckeditor/init
//= require cocoon
//= require foundation/foundation.js
//= require foundation/foundation.topbar.js
//= require foundation/foundation.reveal.js
//= require foundation/foundation.alert.js
//= require_tree .

$(document).ready(function() {

  $(document).foundation();

  // Rollover logo
  $('.logo').mouseover(function() {
    $(this).addClass('animated tada');
  });

  // Rollout logo
  $('.logo').mouseleave(function() {
    $(this).removeClass('animated tada');
  });

  // Rollover featured
  $('.project-logo').mouseover(function() {
    $(this).addClass('animated pulse');
  });

  // Rollout featured
  $('.project-logo').mouseleave(function() {
    $(this).removeClass('animated pulse');
  });

  // Draws the progressBar over a collection
  progressDraw($('.progress-bar'));
  progressMarker();
  facebookShare();
  twitterShare();
  initMapDisplay();

});


function progressDraw($element) {
  for(x = 0; x < $element.length; ++x) {
    _self = $element[x];
    amount = $(_self).data('funded');
    progressWidth = amount * $element.width() / 100;
    $(_self).find('div').animate({ width: progressWidth }, 1500);
    // $('.percent').text(Math.ceil(progressWidth/10)+"%");
    // $('.percent').animate({ left: progressWidth }, 1500);
  };
};

function progressMarker() {
  amount = $('.progress-bar').data('funded');
  progressWidth = amount * $('.progress-bar').width() / 100;
  count = 0;
  window.setInterval(function() {
    // var count = 0;
    amount = $('.progress-bar').data('funded');
    if(count <= amount) {
      $('.percent').text(count+"%");
      ++count;
    };
  }, 50 );
  // $('.percent').text(amount+"%");
  $('.percent').animate({ left: progressWidth-10 }, 1500);
};

function facebookShare() {

  (function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&appId=1456348377956566&version=v2.0";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

}

function twitterShare() {
  !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="https://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
}

  function initMapDisplay() {
    // hide "add reward button after it's clicked 5 times"
    var rewardCount = 0;
    $('#add-reward').click(function() {
      rewardCount++;
      if(rewardCount >= 5) {
          $(this).hide(); //could disable the button here
      }
    })

    // initalize for mapbox
    var longitude = $('#map').data('long');
    var latitude = $('#map').data('lat');
    var title = $('#map').data('title');
    var description = $('#map').data('description');
    // 12 is the zoom
    var map = L.mapbox.map('map', 'dhurley99.ipn4bc66').setView([latitude, longitude], 13);
    // add pin to project show page
    L.mapbox.featureLayer({
      // this feature is in the GeoJSON format: see geojson.org
      // for the full specification
      type: 'Feature',
      geometry: {
        type: 'Point',
        // coordinates here are in longitude, latitude order because
        // x, y is the standard for GeoJSON and many formats
        coordinates: [
          longitude,
          latitude
        ]
      },
      properties: {
        title: title,
        description: description,
        // one can customize markers by adding simplestyle properties
        // https://www.mapbox.com/foundations/an-open-platform/#simplestyle
        'marker-size': 'large',
        'marker-color': '#BE9A6B',
        'marker-symbol': 'beer'
      }
    }).addTo(map);
  }



