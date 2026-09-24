class_name MUW_Waypoints_Operations_Factory

var _waypoints_factory : MUW_Waypoints_Factory
var _world : MUW_World

func _init(waypoints_factory : MUW_Waypoints_Factory, world : MUW_World):

	_waypoints_factory = waypoints_factory
	_world = world


func create_3d_connected_path(parent_node : Node, camera : Camera, size : Vector2,  world : World):

	var connected_waypoints = _waypoints_factory.create_3d(parent_node, size, camera, world)
	return MUW_Connected_Waypoints_Operations.new(connected_waypoints, _world)
