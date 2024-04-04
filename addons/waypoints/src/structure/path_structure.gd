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
			for id in range(points.size() - 1):

				var current_pos = points[id]
				var next_pos = points[id + 1]
				_set_directions(current_pos, next_pos)
				_set_directions(next_pos, current_pos)
		
		for direction in _directions:
			var total = 0
			for key in _directions[direction]:
				total += _directions[direction][key]
			_map.update(direction, total)
		_mask.set_shader_param("map", _map.get_map())
				


func _set_directions(pos : Vector3, next_pos : Vector3):

	var direction = Vector3(pos.x - next_pos.x, 0, pos.z - next_pos.z)
	var pos_id = Vector2(pos.x, pos.z)
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

	if !_directions.has(pos_id):
		_directions[pos_id] = {}
	_directions[pos_id][id] = directions[id]
