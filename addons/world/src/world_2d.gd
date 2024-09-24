class_name MUW_World_2d

var _waypoint_node_operations_factory : MUW_Node_Waypoints_Operations_Factory

func _init(waypoint_node_operations_factory : MUW_Node_Waypoints_Operations_Factory):
	_waypoint_node_operations_factory = waypoint_node_operations_factory 
	

func create_node_waypoints(parent_node : Node, tilemap : TileMap, map_world : MUW_World):
	_waypoint_node_operations_factory.create_2d(parent_node, tilemap, map_world)