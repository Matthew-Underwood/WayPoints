class_name MUW_Waypoints_Factory

var _pathing_factory : MUP_Pathing_Factory
var _world : MUP_World
var _transformer_factory : MUW_Waypoint_Transformer_Factory
var _parent_node : Node
var _waypoint_factory : MUW_Waypoint_Factory

func _init(
	pathing_factory : MUP_Pathing_Factory,
	world : MUP_World,
	transformer_factory : MUW_Waypoint_Transformer_Factory,
	parent_node : Node
):
	_world = world
	_pathing_factory = pathing_factory
	_transformer_factory = transformer_factory
	_parent_node = parent_node


func create_2d(tilemap : TileMap) -> Node2D:
	var tilemap_transformer = _transformer_factory.create_tilemap_transformer(tilemap)
	var packed_waypoints = preload("res://addons/waypoints/scenes/2d/waypoints.tscn")
	var waypoint = preload("res://addons/waypoints/scenes/2d/waypoint.tscn")
	return _create_waypoints(tilemap_transformer, packed_waypoints, waypoint)


func create_spatial() -> Spatial:
	var mesh_transformer = _transformer_factory.create_mesh_transformer()
	var packed_waypoints = preload("res://addons/waypoints/scenes/spatial/waypoints.tscn")
	var waypoint = preload("res://addons/waypoints/scenes/spatial/waypoint.tscn")
	return _create_waypoints(mesh_transformer, packed_waypoints, waypoint)
	

func _create_waypoints(transformer, packed_waypoints : PackedScene, packed_waypoint : PackedScene):

	var waypoint_factory = MUW_Waypoint_Factory.new(transformer, packed_waypoint)
	var pathing = _pathing_factory.create(_world)
	var waypoints = packed_waypoints.instance()
	_parent_node.add_child(waypoints)
	waypoints.set_waypoint_factory(waypoint_factory)
	waypoints.set_world(_world)
	waypoints.set_pathing(pathing)
	return waypoints
