class_name MUT_Cursor_Area


func get_vertices(pos : Vector2, size : Vector2) -> Array:
	var vertices = []
	var start = pos - (size * 0.5).floor()
	for x in range(size.x + 1):
		for y in range(size.y + 1):
			vertices.append(Vector2(start.x + x, start.y + y))
	return vertices