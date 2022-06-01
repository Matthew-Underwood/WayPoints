class_name MUW_Waypoint_Transformers_Tilemap_Transformer

var _tilemap : TileMap


func _init(tilemap : TileMap):
	_tilemap = tilemap


func transform(pos : Vector3) -> Vector2:
	var world_pos = _tilemap.map_to_world(Vector2(pos.x, pos.y))
	var test = world_pos + (_tilemap.cell_size / 2)
	return test
