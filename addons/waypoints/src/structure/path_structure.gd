class_name MUW_Path_Structure

var _map : MUT_Texture_Map
var _mask


func _init(map : MUT_Texture_Map, mask):

	_map = map
	_mask = mask


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
				for id in corners[pos]:
					corner_total += corners[pos][id]
				corners.erase(pos)


			if path_total == 256:
				col = Vector3(0, 1, corner_total)
			if path_total > 256:
				col = Vector3(path_total - 256, 1, corner_total)
			if path_total < 256:
				col = Vector3(path_total, 0, corner_total)

			_map.update(pos, col)

		# Finish off with positions that only contain corners
		for pos in corners:
			var corner_total = 0
			for id in corners[pos]:
				corner_total += corners[pos][id]
			var col = Vector3(0, 0, corner_total)
			_map.update(pos, col)

		_mask.set_shader_param("bezier_path_map", _map.get_map())
