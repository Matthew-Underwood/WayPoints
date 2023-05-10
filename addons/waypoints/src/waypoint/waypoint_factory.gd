class_name MUW_Waypoint_Factory

var _packed_waypoint : PackedScene
var _points

func _init(packed_waypoint : PackedScene, points):
	_packed_waypoint = packed_waypoint
	_points = points

func create(waypoint_override):
	var waypoint = _packed_waypoint.instance()
	if waypoint_override != null:
		waypoint.set_script(waypoint_override)
	if _points != null:
		waypoint.set_points(_points)
	return waypoint


