class_name MUW_Tiles_Processor_3d

var _raycast : RayCast
enum {TILE_TYPE_FLAT, TILE_TYPE_CORNER, TILE_TYPE_SLOPE, TILE_TYPE_L_JOIN}

func _init(raycast : RayCast):
	_raycast = raycast


func create(world_pos : Vector2):
	var tile = {
		"center_position" : _pick_tile_center(world_pos),
		"type" : TILE_TYPE_FLAT 
	}
	return tile


func _pick_tile_center(world_pos : Vector2) -> Vector3:
	var raycast_pos = Vector3(world_pos.x + 0.5, 5, world_pos.y  + 0.5)
	_raycast.transform.origin = raycast_pos
	_raycast.force_raycast_update()
	return _raycast.get_collision_point()
