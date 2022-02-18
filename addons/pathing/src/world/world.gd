class_name MU_World

var _size : Vector2
var _non_walkable_points : Array
var _tile_map : TileMap

func _init(size : Vector2, non_walkable_points : Array, tile_map : TileMap):
	_size = size
	_non_walkable_points = non_walkable_points
	_tile_map = tile_map
	

func getSize() -> Vector2:
	return _size


func get_non_walkable_points() -> Array:
	return _non_walkable_points
	

func is_walkable(pos : Vector2) -> bool:
	var world_pos = global_to_world(pos)
	if is_out_of_bounds(world_pos):
		return false
	
	if get_non_walkable_points().find(world_pos) != -1:
		return false
	return true


func is_out_of_bounds(point : Vector2):
	return point.x < 0 or point.y < 0 or point.x >= _size.x or point.y >= _size.y


func global_to_world(pos : Vector2) -> Vector2:
	return _tile_map.world_to_map(pos)


func world_to_global(pos : Vector2) -> Vector2:
	return _tile_map.map_to_world(pos) + Vector2(16, 16)
	

func get_world() -> TileMap:
	return _tile_map
	
