class_name MUW_World_3d

var _waypoint_operations_factory : MUW_Waypoints_Operations_Factory
var _waypoint_node_operations_factory : MUW_Node_Waypoints_Operations_Factory

func _init(
	waypoint_operations_factory : MUW_Waypoints_Operations_Factory,
	waypoint_node_operations_factory : MUW_Node_Waypoints_Operations_Factory
):

	_waypoint_operations_factory = waypoint_operations_factory 
	_waypoint_node_operations_factory = waypoint_node_operations_factory 
	

func create_waypoints(parent_node : Node, camera : Camera, world : World) -> MUW_Waypoints_Operations_Registry:

	var switching_waypoints = waypoint_operations_factory.create_switching_paths(parent_node)
	var static_waypoints = _waypoint_operations_factory.create_3d_static_path(parent_node, camera, Vector2(10, 10), world)
	var connected_waypoints = _waypoint_operations_factory.create_3d_connected_path(parent_node, camera, Vector2(10, 10), world)

	return MUW_Waypoints_Operations_Registry.new(static_waypoints, connected_waypoints, switching_waypoints)


func create_node_waypoints(parent_node : Node, camera : Camera, world : World) -> MUW_Node_Waypoints_Operations:
	
	return _waypoint_node_operations_factory.create_3d(parent_node, camera, world)
