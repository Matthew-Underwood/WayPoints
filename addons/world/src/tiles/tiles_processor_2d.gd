class_name MUW_Tiles_Processor_2d

var _tilemap : TileMap
enum {TILE_TYPE_FLAT, TILE_TYPE_CORNER, TILE_TYPE_SLOPE, TILE_TYPE_L_JOIN}

func _init(tilemap : TileMap):
	_tilemap = tilemap


func create(world_pos : Vector2, tile_data : Dictionary) -> Dictionary:

	var tile_center_position = _get_tile_center(world_pos)
	var tile = {
		"world_positions" : { (world_pos + Vector2(0.5, 0.5)) : Vector3(tile_center_position.x, tile_center_position.y, 0) },
		"type" : TILE_TYPE_FLAT 
	}
	return tile


func _get_tile_center(world_pos : Vector2) -> Vector2:
	var global_pos = _tilemap.map_to_world(world_pos)
	return global_pos + (_tilemap.cell_size / 2)

