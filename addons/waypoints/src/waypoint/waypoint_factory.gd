class_name MUW_Waypoint_Factory

var _master_node
var _packed_waypoints : PackedScene
var _packed_waypoint : PackedScene
var _points

func _init(master_node, packed_waypoints : PackedScene, packed_waypoint : PackedScene, points = null):
	_master_node = master_node
	_packed_waypoints = packed_waypoints
	_packed_waypoint = packed_waypoint
	_points = points

func create(waypoint_data : MUW_Waypoint_Data) -> Node:

	var waypoint = _packed_waypoint.instance()
	waypoint.set_waypoint_data(waypoint_data)
	
	if _points != null:
		waypoint.set_points(_points)

	var waypoints = _master_node.get_node_or_null("WayPoints")
	if waypoints == null:
		waypoints = _packed_waypoints.instance()
		_master_node.add_child(waypoints)
	waypoints.add_child(waypoint)
	return waypoint


