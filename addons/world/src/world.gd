class_name MUW_World

var _screen_to_world_transformer
var _tiles : MUW_Tiles
var _waypoints

func _init(screen_to_world_transformer, tiles : MUW_Tiles, waypoints):
	_screen_to_world_transformer = screen_to_world_transformer
	_waypoints = waypoints
	_tiles = tiles
	
	
func is_walkable(pos : Vector2) -> bool:
	var world_pos = _screen_to_world_transformer.transform(pos)
	if !_tiles.is_walkable(world_pos) or !_tiles.has_tile(world_pos):
		return false
	return true


func get_waypoints():
	return _waypoints