extends WayPoint


func _draw():

	if !_path.empty():
		for point in range(1, len(_path)):
			
			var start_world_position = _path[point - 1]
			var end_world_position = _path[point]

			draw_line(start_world_position, end_world_position, Color.blue, 1, true)
			draw_circle(end_world_position, 2, Color.blue)


