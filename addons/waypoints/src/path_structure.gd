class_name MUW_Path_Structure

var _waypoint_data: Array
var _map: MUT_Texture_Map
var _mask

func _init(map : MUT_Texture_Map, mask):
	_map = map
	_mask = mask

func create(waypoint_data: MUW_Waypoint_Data):
	_waypoint_data.append(waypoint_data)
	_set_path()


func update(id: int, waypoint_data: MUW_Waypoint_Data):
	_waypoint_data[id] = waypoint_data
	_set_path()


func remove(id: int):
	_waypoint_data.remove(id)
	_set_path()


func _set_path():
	
	var all_points = {}
	if !_waypoint_data.empty():

		for waypoint_data in _waypoint_data:

			var points = waypoint_data.get_path()
			for id in range(points.size() - 1):

				var current_pos = points[id]
				var next_pos = points[id + 1]
				
				var colour_id = self._get_id(current_pos, next_pos)
				var colour_id2 = self._get_id(next_pos, current_pos)

				if all_points.has(next_pos):
					all_points[next_pos] = colour_id2 + all_points[next_pos]
				else:
					all_points[next_pos] = colour_id2
				
				if all_points.has(current_pos):
					all_points[current_pos] = colour_id + all_points[current_pos]
				else:
					all_points[current_pos] = colour_id
		
		for pos in all_points:
			_map.update(pos, all_points[pos])
		_mask.set_shader_param("map", _map.get_map())
				


func _get_id(pos_from : Vector3, pos_to : Vector3):

	var direction = pos_from - pos_to
	direction = Vector2(direction.x, direction.z)
	var directions = {
			Vector2(0.5, 0) : 1,
			Vector2(0.5, 0.5) : 2,
			Vector2(0, 0.5) : 4,
			Vector2(-0.5, -0.5) : 8,
			Vector2(0, -0.5) : 16,
			Vector2(-0.5, -0.5) : 32,
			Vector2(-0.5, 0) : 64,
			Vector2(-0.5, 0.5) : 128
	}

	return directions[direction]
	
