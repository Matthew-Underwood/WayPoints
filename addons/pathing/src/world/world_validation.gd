class_name MU_WorldValidation

var _world


func _init(world):
	_world = world

	
func is_walkable(point : Vector2) -> bool:
	
	if is_out_of_bounds(point):
		return false
	
	if _world.get_non_walkable_points().has(point):
		return false
		
	return true
	

func is_out_of_bounds(point : Vector2):
	var size = _world.getSize()
	return point.x < 0 or point.y < 0 or point.x >= size.x or point.y >= size.y

