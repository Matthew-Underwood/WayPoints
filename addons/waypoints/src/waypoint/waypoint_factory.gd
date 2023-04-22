class_name MUW_Waypoint_Factory

var _packed_waypoint

func _init(packed_waypoint):
	_packed_waypoint = packed_waypoint


func create(waypoint_override):
	var waypoint = _packed_waypoint.instance()
	if waypoint_override != null:
		waypoint.set_script(waypoint_override)
	return waypoint


