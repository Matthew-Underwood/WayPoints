extends Node2D


func _ready():
	#unique_ids_from_vec2(200, 200)
	build_points(3, 3)

func build_points(max_x : int, max_y : int):

	var ids = {}
	for x in range(max_x):
		for y in range(max_y):

			var relative_vectors = [
				Vector2.ZERO,
				Vector2(0, 0.5),
				Vector2(0, 1),
				Vector2(0.5, 0),
				Vector2(1, 0),
				Vector2(0.5, 0.5),
				Vector2(1, 0.5),
				Vector2(0.5, 1),
				Vector2.ONE
			]

			var v = Vector2(x, y)
			for relative_vector in relative_vectors:
				v = Vector2(x + relative_vector.x, y + relative_vector.y)
				var id = v.x * pow(8, 2) + v.y * pow(128, 2)
				if !ids.has(id):
					ids[id] = v
	print(str(ids.size()) + " ids from " + str(Vector2(max_x, max_y)))
	

func unique_ids_from_vec2(max_x : int, max_y : int):

	var ids = {}
	var duplicate_id_pos = null

	for x in range(max_x):
		for y in range(max_y):
			var v = Vector2(x, y)
			var id = x * pow(8, 2) + y * pow(128, 2)
			if !ids.has(id):
				duplicate_id_pos = ids[id]
				print("Duplicate id: " + str(id) + " at " + str(v) + " and " +  str(duplicate_id_pos))
				break
			ids[id] = v

			if x == (max_x - 1) && y == (max_y - 1):
				print("Max id: " + str(id))

		if duplicate_id_pos != null:
			break
	
	if duplicate_id_pos == null:
		print("Array has all unique ids :)")
	
