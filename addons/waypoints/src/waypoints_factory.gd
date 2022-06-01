class_name MUW_Waypoints_Factory

var _pathing_factory : MUP_Pathing_Factory
var _world : MUP_World
var _waypoints_packed : PackedScene
var _transformer_factory : MUW_Waypoint_Transformer_Factory

func _init(
	pathing_factory : MUP_Pathing_Factory,
	world : MUP_World,
	transformer_factory : MUW_Waypoint_Transformer_Factory
):
	_world = world
	_pathing_factory = pathing_factory
	_transformer_factory = transformer_factory

func create_2d() -> Node2D:
	var tilemap_transformer = _transformer_factory.create_tilemap_transformer()
	# TODO Need to seperate this tscn into 2d and 3d
	var tilemap_waypoint = preload("res://addons/waypoints/scenes/tilemap_waypoint.tscn")
	return _create_waypoints(tilemap_transformer, tilemap_waypoint)


func create_spatial() -> Spatial:
	var mesh_transformer = _transformer_factory.create_mesh_transformer()
	# TODO Need to seperate this tscn into 2d and 3d
	var spatial_waypoint = preload("res://addons/waypoints/scenes/spatial_waypoint.tscn")
	return _create_waypoints(mesh_transformer, spatial_waypoint)
	

func _create_waypoints(transformer, packed_waypoint : PackedScene):
	var pathing = _pathing_factory.create(_world)
	var waypoints = _waypoints_packed.instance()
	waypoints.set_waypoint(packed_waypoint)
	waypoints.set_world(_world)
	waypoints.set_pathing(pathing)
	waypoints.set_waypoint_transform(transformer)
	return waypoints
