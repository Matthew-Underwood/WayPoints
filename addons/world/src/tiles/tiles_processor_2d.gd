class_name MUW_Tiles_Processor_2d

var _tilemap : TileMap
enum {TILE_TYPE_FLAT, TILE_TYPE_CORNER, TILE_TYPE_SLOPE, TILE_TYPE_L_JOIN}

func _init(tilemap : TileMap):
	_tilemap = tilemap

func create(world_pos : Vector2, tile_data : Dictionary):
	var tile = {
		"center_position" : _pick_tile_center(world_pos),
		"type" : TILE_TYPE_FLAT 
	}
	return tile


func _pick_tile_center(world_pos : Vector2) -> Vector3:
	var global_pos = _tilemap.map_to_world(world_pos)
	global_pos = global_pos + (_tilemap.cell_size / 2)
	return Vector3(global_pos.x, global_pos.y, 0)

