class_name Waypoints_Factory

var _pathing_factory : MUP_Pathing_Factory
var _world_factory : MUP_World_Factory
var _waypoints_packed : PackedScene
var _transformer_factory : MUW_Transformer_Factory

func _init(
	pathing_factory : MUP_Pathing_Factory,
	world_factory : MUP_World_Factory,
	transformer_factory : MUW_Transformer_Factory
):
	_waypoints_packed = preload("res://addons/waypoints/scenes/waypoints.tscn")
	_world_factory = world_factory
	_pathing_factory = pathing_factory
	_transformer_factory = transformer_factory

func create_2d(tilemap : TileMap) -> WayPoints:
	var tilemap_world = _world_factory.create_2d(tilemap)
	var tilemap_transformer = _transformer_factory.create_tilemap_transformer()
	return _create_waypoints(tilemap_world, tilemap_transformer)

func create_spatial(camera : Camera, world : World) -> WayPoints:
	var spatial_world = _world_factory.create_spatial(camera, world)
	var mesh_transformer = _transformer_factory.create_mesh_transformer()
	return _create_waypoints(spatial_world, mesh_transformer)
	

func _create_waypoints(world, transformer) -> WayPoints:
	var pathing = _pathing_factory.create(world)
	var waypoints = _waypoints_packed.instance()
	waypoints.set_world(world)
	waypoints.set_pathing(pathing)
	waypoints.set_waypoint_transform(transformer)
	return waypoints
