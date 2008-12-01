    var ads

    function initialize() {
	if (GBrowserIsCompatible()) {    
      
	var map = new GMap2(document.getElementById("map_canvas"));
	map.setCenter(new GLatLng(37.4419, -122.1419), 13);
	
	map.addControl(new GLargeMapControl);
	map.addControl(new GMapTypeControl());
	
	geocoder    = new GClientGeocoder();	

	for (var i = 0; i < ads.length; i++) {
	    var ad = ads[i];

	    tempMarker = geocoder.getLatLng(ad.address, createMarker);
		
	    map.addOverlay(tempMarker);
	}
	}
    }

    function createMarker(latlng) {
	var marker = new GMarker(latlng);
	
	return marker;
    	    
    }

