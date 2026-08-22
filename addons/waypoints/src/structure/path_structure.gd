class_name MUW_Path_Structure

var _path_material

func _init(path_material : MUW_Path_Material):
	_path_material = path_material 


func send(path_store : MUW_Path_Directions_Store):
	
	_path_material.clear_map()

	for layer in path_store.get_all_layers():
		var directions = path_store.get_all_directions(layer)
		var corners = path_store.get_all_corners(layer)

		for pos in directions:
			var path_total = 0
			var corner_total = 0
			var col = Vector3.ZERO
			for id in directions[pos]:
				path_total += directions[pos][id]
				if corners.has(pos):
					for corner_id in corners[pos]:
						corner_total += corners[pos][corner_id]
					corners.erase(pos)
			_path_material.update_map(pos, Vector3(path_total, corner_total, 0), layer)

		for pos in corners:
			var corner_total = 0
			for id in corners[pos]:
				corner_total += corners[pos][id]
				_path_material.update_map(pos, Vector3(0, corner_total, 0), layer)

		_path_material.update_material(layer)
