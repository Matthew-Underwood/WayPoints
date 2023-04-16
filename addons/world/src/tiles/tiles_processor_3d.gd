class_name MUW_Tiles_Processor_3d

var _raycast : RayCast
var _data : Dictionary
enum {TILE_TYPE_FLAT, TILE_TYPE_CORNER, TILE_TYPE_SLOPE, TILE_TYPE_L_JOIN}


func _init(raycast : RayCast):
	_raycast = raycast


func create(world_pos : Vector2, tile_data : Dictionary) -> Dictionary:

	var pick_pos = Vector3(world_pos.x, 5, world_pos.y)
	var tile_type = tile_data["type"]
	_data = {
		"world_positions" : {},
		"type" : tile_type 
	}

	_add_position(Vector3(pick_pos) + Vector3(0.5, 0, 0.5))

	if tile_type in [TILE_TYPE_SLOPE, TILE_TYPE_CORNER]:
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
	var picked_position = _pick_point(pick_position)
	_data["world_positions"][Vector2(picked_position.x, picked_position.z)] = picked_position
	return 


func _pick_point(raycast_pos : Vector3) -> Vector3:
	_raycast.transform.origin = raycast_pos
	_raycast.force_raycast_update()
	return _raycast.get_collision_point()

