class_name MUW_World

var _dimension_processor
var _size : Vector2
var _non_walkable_points = []
var _screen_to_world_transformer
var _tiles : MUW_Tiles

func _init(
	dimension_processor,
	size : Vector2,
	non_walkable_points : Array,
	screen_to_world_transformer,
	tiles : MUW_Tiles
	):
	_dimension_processor = dimension_processor
	_size = size
	_non_walkable_points = non_walkable_points
	_screen_to_world_transformer = screen_to_world_transformer
	_tiles = tiles
	
	

func get_size() -> Vector2:
	return _size


func get_non_walkable_points() -> Array:
	return _non_walkable_points
	

func is_walkable(pos : Vector2) -> bool:
	var world_pos = screen_to_world_pos(pos)
	if is_out_of_bounds(world_pos):
		return false
	
	if get_non_walkable_points().find(world_pos) != -1:
		return false
	return true


func is_out_of_bounds(point : Vector2) -> bool:
	return point.x < 0 or point.y < 0 or point.x >= _size.x or point.y >= _size.y


func screen_to_world_pos(screen_pos : Vector2) -> Vector2:
	return _screen_to_world_transformer.transform(screen_pos)


func get_tiles() -> MUW_Tiles:
	return _tiles
