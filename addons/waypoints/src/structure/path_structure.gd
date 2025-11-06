class_name MUW_Path_Structure

var _map : MUT_Texture_Map
var _mask


func _init(map : MUT_Texture_Map, mask):

	_map = map
	_mask = mask


func send(path_store : MUW_Path_Directions_Store):

	if !path_store.is_empty():
		var directions = path_store.get_all_directions()

		for pos in directions:
			var path_total = 0
			var col = Vector3.ZERO

			for id in directions[pos]:
				path_total += directions[pos][id]

			_map.update(pos, Vector3(path_total, 0, 0))

		_mask.set_shader_param("bezier_path_map", _map.get_map())
