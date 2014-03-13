var map = null; 
var geocoder = null; 
var cityMarker = null; 
var cityCircle = null; 
var startValue = 5;

/**
 * Updates the map center based on the address in #address
 */
function codeAddress() {
    var address = document.getElementById('address').value;
    geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
            cityMarker.setPosition(map.getCenter());
            updateCoordsOnPage(map.getCenter());
        } else {
            alert('Geocode was not successful for the following reason: ' + status);
        }
    });
}

/**
 * Updates the hidden fields with the current center lat and lng
 * @param {pos} pos - The map's center position element. 
 */
function updateCoordsOnPage(pos) {
    var lat = document.getElementById('question_latitude');
    var lng = document.getElementById('question_longitude');
    lat.innerHTML = Math.round(pos.lat() * 10) / 10;
    lng.innerHTML = Math.round(pos.lng() * 10) / 10;
}

function handleClick(event) {
    cityMarker.setPosition(event.latLng); 
    updateCoordsOnPage(event.latLng); 
}

function init() {
    geocoder = new google.maps.Geocoder();
    var mapDiv = document.getElementById('map-canvas');
    if (mapDiv != null) {
        map = new google.maps.Map(mapDiv, {
            center: new google.maps.LatLng(37.424105999999, -122.1660756),
            zoom: 10, 
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        cityMarker = new google.maps.Marker({
            position: map.getCenter(), 
            map: map,
           // draggable: true, 
            visible: true});
        cityCircle = new google.maps.Circle({
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillOpacity: 0.15,
            map: map,
            center: map.getCenter(),
            radius: milesToMeters(startValue),
            visible: true
        });
        cityCircle.bindTo('center', cityMarker, 'position');
        updateCoordsOnPage(map.getCenter());
        google.maps.event.addListener(map, 'click', handleClick);
        //google.maps.event.addListener(cityMarker, 'drag', function() { updateCoordsOnPage(cityMarker.getPosition()); } );
    }
}

function milesToMeters(miles) {
    return miles * 1609.3;
}

// $(function() {
//     $( "#slider-range-max" ).slider({
//         range: "max",
//         min: 1,
//         max: 20,
//         value: startValue,
//         slide: function( event, ui ) {
//             $( "#question_radius" ).val( ui.value );
//             updateRadius(ui.value);
//         }
//     });
//     $( "#question_radius" ).val( $( "#slider-range-max" ).slider( "value" ) );
// });

function updateRadius(rad) {
    cityCircle.setRadius(milesToMeters(rad));
}

google.maps.event.addDomListener(window, 'load', init);

function handleChangedRadius() {
   var select = document.getElementById('question_radius');
   updateRadius(select.value);
}
