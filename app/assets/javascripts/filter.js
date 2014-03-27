var map = null;
var geocoder = null; 

function filterCodeAddress() {
    var address = document.getElementById('address').value;
    geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
        } else {
            alert('Geocode was not successful for the following reason: ' + status);
        }
    });
}

function initBoundingBox() {
    geocoder = new google.maps.Geocoder();
    var mapDiv = document.getElementById('filter-map-canvas');
    if (mapDiv != null) {
        map = new google.maps.Map(mapDiv, {
            center: new google.maps.LatLng(37.254687, 127.049153),
            zoom: 10, 
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        google.maps.event.addDomListener(map, 'bounds_changed', whenBoundsChange);
    }
}

function whenBoundsChange() {
    var bounds = map.getBounds();
    var ne = bounds.getNorthEast();
    var sw = bounds.getSouthWest();
    var url = "search?n=" + encodeURIComponent(ne.lat()) + "&e=" + encodeURIComponent(ne.lng()) + "&s=" + encodeURIComponent(sw.lat()) + "&w=" + encodeURIComponent(sw.lng());
    jQuery.get(url, function(data) {
        document.getElementById('all_questions').innerHTML = data; 
    });
}

google.maps.event.addDomListener(window, 'load', initBoundingBox);
