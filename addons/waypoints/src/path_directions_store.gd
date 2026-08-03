class_name MUW_Path_Directions_Store

var _path_directions = {}

var _path_corners = {}

var _relative_id_corners = {
	Vector2(-1, 1) : {Vector2(0, 1) : 1, Vector2(-1, 0) : 128},
	Vector2(1, -1) : {Vector2(0, -1) : 128, Vector2(1, 0) : 1},
	Vector2(-1, -1) : {Vector2(-1, 0) : 4, Vector2(0, -1) : 32},
	Vector2(1, 1) : {Vector2(0, 1) : 4, Vector2(1, 0) : 32}
}

var _relative_ids = {
	Vector2(-1, -1) : 1,
	Vector2(0, -1) : 2,
	Vector2(1, -1) : 4,
	Vector2(-1, 0) : 8,
	Vector2(1, 0) : 16,
	Vector2(-1, 1) : 32,
	Vector2(0, 1) : 64,
	Vector2(1, 1) : 128
}

func get_all_directions(layer = null) -> Dictionary:

	if layer == null:
		return _path_directions

	if !_path_directions.has(layer):
		return _path_directions

	return _path_directions[layer]


func get_all_corners(layer = null) -> Dictionary:

	if layer == null:
		return _path_corners

	if !_path_corners.has(layer):
		return _path_corners

	return _path_corners[layer]


func set_directions(directions : Dictionary):

	_path_directions = directions


func set_corners(corners : Dictionary):

	_path_corners = corners


func get_corners(pos : Vector2, layer : int) -> Dictionary:

	return _path_corners[layer][pos]


func get_directions(pos : Vector2, layer : int) -> Dictionary:

	return _path_directions[layer][pos]


func has_directions(pos : Vector2, layer : int) -> bool:

	return _path_directions[layer].has(pos)


func has_corners(pos : Vector2, layer : int) -> bool:

	return _path_corners[layer].has(pos)


func is_empty() -> bool:

	return _path_directions.empty() && _path_corners.empty()


func add_direction(pos : Vector2, relative_pos : Vector2, layer : int) -> void:
	
	var offset = relative_pos - pos
	var direction = _relative_ids[offset]

	if !_path_directions.has(layer):
		_path_directions[layer] = {}

	if offset in _relative_id_corners.keys():
		_add_corner(offset, pos, layer)

	if !self.has_directions(pos, layer):
		_path_directions[layer][pos] = {}

	_path_directions[layer][pos][direction] = direction


func _add_corner(offset : Vector2, pos : Vector2, layer : int) -> void:

	var relative_tiles = _relative_id_corners[offset]

	if !_path_corners.has(layer):
		_path_corners[layer] = {}

	for relative_pos in relative_tiles:
		var corner_id = relative_tiles[relative_pos]
		var tile_position = relative_pos + pos

		if !self.has_corners(tile_position, layer):
			_path_corners[layer][tile_position] = {}

		_path_corners[layer][tile_position][corner_id] = corner_id


func empty() -> void:

	_path_corners = {}
	_path_directions = {}


func remove(pos : Vector2) -> void:

	_path_directions[pos] = {}
	_path_corners[pos] = {}

