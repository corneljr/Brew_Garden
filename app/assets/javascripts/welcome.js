$(document).ready(function() {

  $('.slider').slick({
    dots: true,
    speed: 500,
    autoplay: false
  });

  // This is not visible on the DOM????
  function progressLoader(percent, $element) {
    var progressBarWidth = percent * $element.width() / 100;
    $element.find('div').animate({ width: progressBarWidth }, 1250).html(percent + "%&nbsp;");
  };

});