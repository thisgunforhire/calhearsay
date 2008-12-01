    var map
    var marker    
    var geocoder
    var address

    function initialize() {
      if (GBrowserIsCompatible()) {
	map = new GMap2(document.getElementById("map_canvas"));
	geocoder    = new GClientGeocoder();

	map.addControl(new GLargeMapControl);
	map.addControl(new GMapTypeControl());

  	geocoder.getLatLng(
    	    address,
    	    function(point) {
		if (!point) {
		    alert(address + " not found");
		} else {
		    map.setCenter(point, 13);
		    getAddress(point)
		}
	    }
	);
      }
    }

    function getAddress(latlng) {
      if (latlng != null) {
        address = latlng;
        geocoder.getLocations(latlng, showAddress);
      }
    }

    function showAddress(response) {
      map.clearOverlays();
      if (!response || response.Status.code != 200) {
        alert("Status Code:" + response.Status.code);
      } else {
        place = response.Placemark[0];
        point = new GLatLng(place.Point.coordinates[1],
                            place.Point.coordinates[0]);
	marker = new GMarker(point, {draggable: true});
	map.addOverlay(marker);	

	marker.openInfoWindowHtml(
	'<b>Is this the address you were looking for?</b>' + '<br>' +
        place.address);

	GEvent.addListener(marker, "dragstart", function() {
          map.closeInfoWindow();
        });

        GEvent.addListener(marker, "dragend", getAddress);
      }
    }
        

