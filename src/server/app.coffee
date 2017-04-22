_        = require "underscore"
config   = require "config"
fs       = require "fs"
gtfs     = require "gtfs"
mongoose = require "mongoose"
util     = require "util"

mongoose.Promise = global.Promise
mongoose.connect "mongodb://localhost:27017/gtfs"

# gtfs.import config.gtfsConfig, (err) ->
	# return console.error err.toString() if err
	# console.log "import succesfoel"

# gtfs.getShapesByRoute "openov", 6612, 0
	# .then (shapes) ->
		# if Array.isArray shapes
			# shapes.map (array) ->
				# console.log array.map (s) ->
					# sequence: s.shape_pt_sequence
					# lat: s.shape_pt_lat
					# lng: s.shape_pt_lon
					# dist: s.shape_dist_traveled
	# .catch (err) ->
		# console.error err

gtfs.getShapesByRouteAsGeoJSON "openov", 6612
	.then (shapes) ->
		fs.writeFileSync "route", JSON.stringify shapes, null, 2
	.catch (err) ->
		console.error err

gtfs.getStopsByRouteAsGeoJSON "openov", 6612
	.then (stops) ->
		fs.writeFileSync "stops", JSON.stringify stops, null, 2
	.catch (err) ->
		console.error err

