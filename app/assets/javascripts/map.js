
  $(document).ready(function() {

    

  });


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
