class_name MUW_Waypoints_Factory

var _pathing : MUP_Pathing
var _world : MUW_World
var _transformer_factory : MUW_Waypoint_Transformer_Factory
var _parent_node : Node
var _waypoint_factory

func _init(
	pathing : MUP_Pathing,
	world : MUW_World,
	transformer_factory : MUW_Waypoint_Transformer_Factory,
	parent_node : Node,
	waypoint_factory
):
	_world = world
	_pathing = pathing
	_transformer_factory = transformer_factory
	_parent_node = parent_node
	_waypoint_factory = waypoint_factory

func create_2d(tilemap : TileMap) -> Node2D:
	var tilemap_transformer = _transformer_factory.create_tilemap_transformer(tilemap)
	var packed_waypoints = preload("res://addons/waypoints/scenes/2d/waypoints.tscn")
	#var waypoint = preload("res://addons/waypoints/scenes/2d/waypoint.tscn")
	var waypoints = _create_waypoints(packed_waypoints)
	waypoints.set_origin(Vector3(1, 1, 0))
	return waypoints

func create_spatial() -> Spatial:
	var mesh_transformer = _transformer_factory.create_mesh_transformer()
	var packed_waypoints = preload("res://addons/waypoints/scenes/spatial/waypoints.tscn")
	var waypoints = _create_waypoints(packed_waypoints)
	waypoints.set_origin(Vector3(1, 0, 1))
	return waypoints

func _create_waypoints(packed_waypoints : PackedScene):

	var waypoints = packed_waypoints.instance()
	_parent_node.add_child(waypoints)
	waypoints.set_waypoint_factory(_waypoint_factory)
	waypoints.set_world(_world)
	waypoints.set_pathing(_pathing)
	return waypoints
