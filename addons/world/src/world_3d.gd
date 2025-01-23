class_name MUW_World_3d

var _waypoint_operations_factory : MUW_Waypoints_Operations_Factory
var _waypoint_node_operations_factory : MUW_Node_Waypoints_Operations_Factory

func _init(waypoint_operations_factory : MUW_Waypoints_Operations_Factory, waypoint_node_operations_factory : MUW_Node_Waypoints_Operations_Factory):
	_waypoint_operations_factory = waypoint_operations_factory 
	_waypoint_node_operations_factory = waypoint_node_operations_factory 
	

func create_waypoints(parent_node : Node, camera : Camera, world : World, existing_waypoints : Array) -> MUW_Waypoints_Operations:
	return _waypoint_operations_factory.create_3d(parent_node, camera, Vector2(10, 10), world, existing_waypoints)


func create_node_waypoints(parent_node : Node, camera : Camera, world : World) -> MUW_Node_Waypoints_Operations:
	return _waypoint_node_operations_factory.create_3d(parent_node, camera, world)
