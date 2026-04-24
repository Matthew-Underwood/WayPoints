class_name MUW_Path_Structure

var _path_material_store

func _init(path_material_store : MUW_Path_Material_Store):
	_path_material_store = path_material_store 


func send(path_store : MUW_Path_Directions_Store):

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
			_map.update(pos, Vector3(path_total, corner_total, 0))

		for pos in corners:
			var corner_total = 0
			for id in corners[pos]:
				corner_total += corners[pos][id]
				_map.update(pos, Vector3(0, corner_total, 0))

			_texture_map.update(pos, col)
		_material.set_shader_param("bezier_path_map", _texture_map.get_map())
