class_name MUW_Tiles_Processor_3d

var _raycast : RayCast
enum {TILE_TYPE_FLAT, TILE_TYPE_CORNER, TILE_TYPE_SLOPE, TILE_TYPE_L_JOIN}

func _init(raycast : RayCast):
	_raycast = raycast


func create(world_pos : Vector2, tile_data : Dictionary):

	var pick_pos = Vector3(world_pos.x, 5, world_pos.y)
	var tile_type = tile_data["type"]
	var tile = {
		"center_position" : _pick_tile_center(pick_pos),
		"type" : tile_type 
	}

	if tile_type == TILE_TYPE_SLOPE:
		tile["center_edge"] = _pick_center_edge(pick_pos)
	
	if tile_type == TILE_TYPE_CORNER:
		tile["corner_edge"] = _pick_corner(pick_pos)

	return tile


func _pick_tile_center(pick_pos : Vector3) -> Vector3:
	return _pick_point(Vector3(pick_pos) + Vector3(0.5, 0, 0.5))


func _pick_center_edge(pick_pos : Vector3) -> Vector3:
	var relative_points = [Vector3(0.5, 0, 0), Vector3(1, 0, 0.5), Vector3(0.5, 0, 1), Vector3(0, 0, 0.5)]
	for i in range(len(relative_points) - 1):
		relative_points[i] = pick_pos + relative_points[i]
		
	return _find_highest_from_points(relative_points)


func _pick_corner(pick_pos : Vector3) -> Vector3:
	var relative_points = [Vector3(0, 5, 0), Vector3(1, 5, 0), Vector3(1, 5, 1), Vector3(0, 5, 1)]
	for i in range(len(relative_points) - 1):
		relative_points[i] = pick_pos + relative_points[i]
	
	return _find_highest_from_points(relative_points)


func _find_highest_from_points(points : Array) -> Vector3:
	var highest_point = Vector3.ZERO
	for p in points:
		var picked_point = _pick_point(p)
		if picked_point.y > highest_point.y:
			highest_point = picked_point
	return highest_point


func _pick_point(raycast_pos : Vector3) -> Vector3:
	_raycast.transform.origin = raycast_pos
	_raycast.force_raycast_update()
	return _raycast.get_collision_point()
