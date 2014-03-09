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

function init() {
   geocoder = new google.maps.Geocoder();
        var mapDiv = document.getElementById('filter-map-canvas');
    map = new google.maps.Map(mapDiv, {
        center: new google.maps.LatLng(37.424105999999, -122.1660756),
        zoom: 10, 
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    google.maps.event.addDomListener(map, 'bounds_changed', whenBoundsChange);

}

function whenBoundsChange() {
    var center = map.getCenter();
    var url = "filter_questions?lat=" + encodeURIComponent(center.lat()) + "&lng=" + encodeURIComponent(center.lng());
    jQuery.get(url, function(data) {
        document.getElementById('all_questions').innerHTML = data; 
    });
      
}

google.maps.event.addDomListener(window, 'load', init);
