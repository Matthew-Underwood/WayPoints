extends Sprite

class_name WayPoint
var _path = []


func _draw():

	if !_path.empty():
		for point in range(1, len(_path)):
			var start_world_position = _path[point - 1]
			var end_world_position = _path[point]
			draw_line(start_world_position, end_world_position, Color.green, 1, true)
			draw_circle(end_world_position, 2, Color.green)
			
func hide() -> void:
	_path = []
	update()
	
	
func set_path(path : Array) -> void:
	_path = path
	update()
	

