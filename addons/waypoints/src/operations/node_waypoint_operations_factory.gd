class_name MUW_Node_Waypoints_Operations_Factory

var _waypoints_factory : MUW_Waypoints_Factory
var _world : MUW_World

func _init(waypoints_factory : MUW_Waypoints_Factory, world : MUW_World):
	_waypoints_factory = waypoints_factory
	_world = world


func create_2d(parent_node : Node, tilemap : TileMap):
	var waypoints = _waypoints_factory.create_2d_nodes(parent_node, tilemap)
	return MUW_Node_Waypoints_Operations.new(waypoints, _world)


func create_3d(parent_node : Node, camera : Camera, world : World):
	var waypoints = _waypoints_factory.create_3d_nodes(parent_node, camera, world)
	return MUW_Node_Waypoints_Operations.new(waypoints, _world)