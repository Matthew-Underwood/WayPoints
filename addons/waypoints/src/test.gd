class_name MUW_Path_Structure

var _waypoint_data: Array
var _map: MUT_Texture_Map

func _init(map : MUT_Texture_Map):
	_map = map


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
			for id in range(points.size()):

				var current_pos = points[id]
				var next_pos = points[id + 1]
				current_pos = Vector2(current_pos.x, current_pos.y)
				next_pos = Vector2(next_pos.x, next_pos.y)
				
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
				


func _get_id(pos_from : Vector2, pos_to : Vector2):

	var directions = {
			Vector2(0, 1) : 1,
			Vector2(1, 1) : 2,
			Vector2(1, 0) : 4,
			Vector2(1, -1) : 8,
			Vector2(0, -1) : 16,
			Vector2(-1, -1) : 32,
			Vector2(-1, 0) : 64,
			Vector2(-1, 1): 128
	}
	return directions[pos_from - pos_to]
	