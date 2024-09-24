class_name MUW_World

var _screen_to_world_transformer
var _tiles : MUW_Tiles

func _init(screen_to_world_transformer, tiles : MUW_Tiles):
	_screen_to_world_transformer = screen_to_world_transformer
	_tiles = tiles
	
func is_walkable(pos : Vector2) -> bool:
	var world_pos = _screen_to_world_transformer.transform(pos)
	if !_tiles.has_tile(world_pos) or !_tiles.is_walkable(world_pos):
		return false
	return true

