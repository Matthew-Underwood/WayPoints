class_name MUW_Waypoints_Factory

var _pathing : MUP_Pathing
var _world : MUW_World
var _parent_node : Node
var _waypoint_factory

func _init(
	pathing : MUP_Pathing,
	world : MUW_World,
	parent_node : Node,
	waypoint_factory
):
	_world = world
	_pathing = pathing
	_parent_node = parent_node
	_waypoint_factory = waypoint_factory

func create_2d(tilemap : TileMap) -> Node2D:
	var packed_waypoints = preload("res://addons/waypoints/scenes/2d/waypoints.tscn")
	var waypoints = _create_waypoints(packed_waypoints)
	return waypoints

func create_spatial() -> Spatial:
	var packed_waypoints = preload("res://addons/waypoints/scenes/spatial/waypoints.tscn")
	var waypoints = _create_waypoints(packed_waypoints)
	return waypoints

func _create_waypoints(packed_waypoints : PackedScene):

	var waypoints = packed_waypoints.instance()
	_parent_node.add_child(waypoints)
	waypoints.set_waypoint_factory(_waypoint_factory)
	waypoints.set_world(_world)
	waypoints.set_pathing(_pathing)
	waypoints.set_origin(Vector2(1, 1))
	return waypoints
