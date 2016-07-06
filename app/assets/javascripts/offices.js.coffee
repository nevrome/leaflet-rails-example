## Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

$ ->
  map = L.map('map', {drawControl: true}).setView([48.856, 2.35], 13)

  L.tileLayer("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
      maxZoom: 18
  }).addTo(map)

  for office in $(".office")
    $office = $(office)
    lat = $office.data("latitude")
    lon = $office.data("longitude")
    name = $office.data("name")
    details = $office.data("details")
    marker = L.marker([lat, lon]).addTo(map)
    marker.bindPopup("<b>#{name}</b><br>#{details}")

   pointA = new L.LatLng(48.856, 2.35);
   pointB = new L.LatLng(49, 3);
   pointList = [pointA, pointB];

   firstpolyline = new L.Polyline(pointList, {
   color: 'red',
   weight: 3,
   opacity: 0.5,
   smoothFactor: 1
   });

   firstpolyline.addTo(map);



drawnItems = new L.FeatureGroup();
map.addLayer(drawnItems);

drawControl = new L.Control.Draw({
    edit: {
        featureGroup: drawnItems
    }
});
map.addControl(drawControl);
