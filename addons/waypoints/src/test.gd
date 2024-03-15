class_name MUW_Path_Structure

var _waypoint_data: Array

func create(waypoint_data: MUW_Waypoint_Data):
	_waypoint_data.append(waypoint_data)


#TODO look into if id will reference the waypoint nodes correctly
func update(id: int, waypoint_data: MUW_Waypoint_Data):
	pass


func remove(id: int):
	pass


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
				
				if all_points.has(current_pos):
					all_points[current_pos] = colour_id + all_points[current_pos]
				all_points[current_pos] = colour_id


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
	