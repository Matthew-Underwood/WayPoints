class_name MUW_Path_Structure

var _waypoint_data: Array
var _map: MUT_Texture_Map
var _directions : Dictionary
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
	
	_directions = {}

	if !_waypoint_data.empty():
		for waypoint_data in _waypoint_data:
			var points = waypoint_data.get_path()
			for id in range(points.size()):

				var current_pos = points[id]
				var current_pos_vec2 = Vector2(current_pos.x, current_pos.z)
				if current_pos_vec2 - current_pos_vec2.floor() != Vector2(0.5, 0.5):
					continue
				
				if id - 1 >= 0:
					var previous_pos = points[id - 1]
					var previous_direction = _get_direction(current_pos, previous_pos)
					if !_directions.has(current_pos_vec2.floor()):
						_directions[current_pos_vec2.floor()] = {}
					_directions[current_pos_vec2.floor()][previous_direction] = true

				if id + 1 < points.size():
					var next_pos = points[id + 1]
					var next_direction = _get_direction(current_pos, next_pos)
					if !_directions.has(current_pos_vec2.floor()):
						_directions[current_pos_vec2.floor()] = {}
					_directions[current_pos_vec2.floor()][next_direction] = true
		
		for pos in _directions:
			var total = 0
			for direction_id in _directions[pos]:
				total += direction_id
			_map.update(pos, total)
		_mask.set_shader_param("map", _map.get_map())


func _get_direction(pos : Vector3, pos2 : Vector3) -> int:

	var direction = Vector3(pos.x - pos2.x, 0, pos.z - pos2.z)
	var angle = Vector3(0, 0, 1).signed_angle_to(direction, Vector3(0, 1, 0))
	var id = str(angle).sha1_text().left(4)
	print("Direction : " + str(direction))
	print("Radians : " + str(angle))
	print("SHA1 : " + str(id))
	var directions = {
		"9912" : 1,
		"dffa" : 2,
		"6be4" : 4,
		"b658" : 8,
		"47e2" : 16,
		"4ffb" : 32,
		"340d" : 64,
		"4786" : 128
	}
	return directions[id]
