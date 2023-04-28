class_name MUW_Waypoints_Factory

var _pathing : MUP_Pathing
var _waypoint_packed : PackedScene
var _waypoints_packed : PackedScene
var _transformer

func _init(
	pathing : MUP_Pathing,
	waypoint_packed : PackedScene,
	waypoints_packed : PackedScene,
	transformer
):
	_pathing = pathing
	_waypoint_packed = waypoint_packed
	_waypoints_packed = waypoints_packed
	_transformer = transformer

func create() -> Node:

	var waypoint_factory = MUW_Waypoint_Factory.new(_waypoint_packed)
	var waypoints = _waypoints_packed.instance()
	waypoints.set_waypoint_factory(waypoint_factory)
	waypoints.set_transformer(_transformer)
	waypoints.set_pathing(_pathing)
	#TODO add child in the calling script
	#_parent_node.add_child(waypoints)
	return waypoints
