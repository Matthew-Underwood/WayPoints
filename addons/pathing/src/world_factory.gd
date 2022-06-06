class_name MUP_World_Factory

var _size : Vector2
var _unwalkable_points : Array

func _init(size : Vector2, unwalkable_points = []):
	_size = size
	_unwalkable_points = unwalkable_points

func create_spatial(camera : Camera, world : World) -> MUP_World:
	var mesh_picking = MUP_World_Mesh_Picking.new(camera, world)
	var screen_mesh_transformer = MUP_World_Transformers_Screen_Mesh.new(mesh_picking)
	return MUP_World.new(_size, _unwalkable_points, screen_mesh_transformer)


func create_2d(tilemap : TileMap) -> MUP_World:
	var screen_tilemap_transformer = MUP_World_Transformers_Screen_Tilemap.new(tilemap)
	return MUP_World.new(_size, _unwalkable_points, screen_tilemap_transformer)
