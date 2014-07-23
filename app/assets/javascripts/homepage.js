  $(document).ready(function() {

    // Rollover logo
    $('.logo').mouseover(function() {
      $(this).addClass('animated tada');
    });

    // Rollout logo
    $('.logo').mouseleave(function() {
      $(this).removeClass('animated tada');
    });

    // Rollover featured
    $('.featured').mouseover(function() {
      $(this).addClass('animated infinite pulse');
    });

    // Rollout featured
    $('.featured').mouseleave(function() {
      $(this).removeClass('animated pulse');
    });

    // takes a collection of .progress-bar divs and animates them
    function progressDraw($element) {
      for(x = 0; x < $element.length; ++x) {
        _self = $element[x];
        amount = $(_self).data('funded');
        progressWidth = amount * $element.width() / 100;
        $(_self).find('div').animate({ width: progressWidth }, 1250);
      };
    };


  });