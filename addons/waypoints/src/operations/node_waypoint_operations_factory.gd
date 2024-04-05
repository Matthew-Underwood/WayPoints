class_name MUW_Node_Waypoints_Operations_Factory

var _waypoints_factory : MUW_Waypoints_Factory

func _init(waypoints_factory : MUW_Waypoints_Factory):
	_waypoints_factory = waypoints_factory


func create_2d(parent_node : Node, camera : Camera, world : World, map_world : MUW_World):
	var waypoints =  _waypoints_factory.create_2d_nodes(parent_node)
	return MUW_Node_Waypoints_Operations.new(waypoints, map_world)


func create_3d(parent_node : Node, camera : Camera, world : World, map_world : MUW_World):
	var waypoints =  _waypoints_factory.create_3d_nodes(parent_node)
	return MUW_Node_Waypoints_Operations.new(waypoints, map_world)