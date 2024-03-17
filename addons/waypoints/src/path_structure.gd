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
				current_pos = Vector2(current_pos.x, current_pos.z)
				next_pos = Vector2(next_pos.x, next_pos.z)
				
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
				


func _get_id(pos_from : Vector2, pos_to : Vector2):

	var directions = {
			0 : 1,
			45 : 2,
			90 : 4,
			135 : 8,
			-180 : 16,
			-45 : 32,
			-90 : 64,
			-135 : 128
	}

	var direction = pos_from.direction_to(pos_to)
	var direction_deg = rad2deg(direction.angle_to(Vector2.UP)) as int

	return directions[direction_deg]
	
