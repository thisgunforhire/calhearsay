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
	
	GEvent.addListener(marker, "click", function() {
			marker.openInfoWindowTabsHtml(
				[new GInfoWindowTab("Overview",
					"<div class=\"infowindow\"><h3>Have You Seen Me?</h3><a href=\"../../public/images/example.jpg\" onclick='Slimbox.open(\"../../public/images/example.jpg\",\"Please Find Me!\");return false' rel=\"lightbox\" ><img src=\"../../public/images/example.jpg\" width=150 height=100 align=left></a><br /><br /><body><b>Name:</b>CUJO<br><b>Species:</b>MONKEY<br><b>Color:</b>BROWN<br><b>Last Seen:</b>IN HELL</body></div>"),
				 new GInfoWindowTab("Description","Fo Realz!  Where am I?  I will love you long time.")]
			);
        });
        
	return marker;
    	    
    }

