class_name MUW_Tiles_Processor_3d

var _raycast : RayCast
var _data : Dictionary
var _points


func _init(raycast : RayCast, points):
	_raycast = raycast
	_points = points


func create(world_pos : Vector2, tile_data : Dictionary) -> Dictionary:

	var pick_pos = Vector3(world_pos.x, 5, world_pos.y)
	var tile_type = tile_data["type"]
	_data = {
		"world_positions" : {},
		"type" : tile_type 
	}

	if tile_type == MUW_Tile_Types.INPASSABLE:
		return { "world_positions" : {}, "type" : tile_type }

	_add_position(Vector3(pick_pos) + Vector3(0.5, 0, 0.5))

	if tile_type in [MUW_Tile_Types.SLOPE, MUW_Tile_Types.CORNER]:
		var relative_points = [
			Vector3(0, 0, 0),
			Vector3(0.5, 0, 0),
			Vector3(1, 0, 0),
			Vector3(0, 0, 0.5),
			Vector3(0, 0, 1),
			Vector3(1, 0, 0.5),
			Vector3(0.5, 0, 1),
			Vector3(1, 0, 1),
		]
		for relative_point in relative_points:
			_add_position(Vector3(pick_pos) + relative_point)
	return _data


func _add_position(pick_position : Vector3):
	var picked_position = _pick_point_data(pick_position)
	_data["world_positions"][Vector2(picked_position.x, picked_position.z)] = picked_position


func _pick_point_data(raycast_pos : Vector3) -> Vector3:
	_raycast.transform.origin = raycast_pos
	_raycast.force_raycast_update()
	var picked_point = _raycast.get_collision_point() 
	if !_points.has_point(picked_point):
		_points.add_point(picked_point, {"point" : picked_point, "normal" : _raycast.get_collision_normal()})
	return picked_point


