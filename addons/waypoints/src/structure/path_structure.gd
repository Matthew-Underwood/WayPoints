class_name MUW_Path_Structure

var _path_materials_store

func _init(path_materials_store : MUW_Path_Materials_Store):
	_path_materials_store = path_materials_store 


func send(path_store : MUW_Path_Directions_Store):
	
	var path_material = _path_materials_store.get_all()[0]
	if !path_store.is_empty():
		var directions = path_store.get_all_directions()
		var corners = path_store.get_all_corners()

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
			path_material.update(pos, Vector3(path_total, corner_total, 0))

		for pos in corners:
			var corner_total = 0
			for id in corners[pos]:
				corner_total += corners[pos][id]
				path_material.update(pos, Vector3(0, corner_total, 0))

		path_material.update_material()
