## Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

$ ->
	# create map
	map = L.map('map').setView([
	  48.856
	  2.35
	], 13)

	# add tile layer 
	tileurl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
	tileattribution = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
	L.tileLayer(tileurl, 
	  attribution: tileattribution
	  maxZoom: 18).addTo map

	# add office points
	for office in $(".office")
	  $office = $(office)
	  lat = $office.data("latitude")
	  lon = $office.data("longitude")
	  name = $office.data("name")
	  details = $office.data("details")
	  marker = L.marker([lat, lon]).addTo(map)
	  marker.bindPopup("<b>#{name}</b><br>#{details}")

	# draw testline
	pointA = new (L.LatLng)(48.856, 2.35)
	pointB = new (L.LatLng)(49, 3)
	pointList = [
	  pointA
	  pointB
	]
	firstpolyline = new (L.Polyline)(pointList,
	  color: 'red'
	  weight: 3
	  opacity: 0.5
	  smoothFactor: 1)
	  
	firstpolyline.addTo(map);

	# add drawing layers
	drawnItems = new (L.FeatureGroup)


	# add drawing controls
	drawControl = new (L.Control.Draw)(
	  draw:
	    polyline: false
	    polygon: false 
	    rectangle: true
	    marker: false
	    circle: false
	  edit:
	    featureGroup: drawnItems)
	map.addControl drawControl

	# change colour
	drawControl.setDrawingOptions rectangle: shapeOptions: color: '#000000'

	# react to user drawing
	map.on 'draw:drawstart', (e) ->
	  console.log("drawstart")
	  if map.hasLayer drawnItems
	    console.log("if")
	    drawnItems.eachLayer (layer) ->
	      do drawnItems.removeLayer layer
	    return
	    #drawnItems.removeLayer
	  map.addLayer drawnItems
	  return

	# react to user drawing
	map.on 'draw:created', (e) ->
	  console.log("created")
	  layer = e.layer
	  hunun = layer.getBounds()
	  west = hunun.getEast()
	  console.log(west)
	  drawnItems.addLayer layer
	  return

	# react to editing
	map.on 'draw:edited', (e) ->
	  console.log("edited")
	  layers = e.layers
	  layers.eachLayer (layer) ->
	    #do whatever you want, most likely save back to db
	    return
	  return

