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
					print(current_pos_vec2)
					_set_direction(current_pos_vec2, previous_direction)

				if id + 1 < points.size():
					var next_pos = points[id + 1]
					var next_direction = _get_direction(current_pos, next_pos)
					print(current_pos_vec2)
					_set_direction(current_pos_vec2, next_direction)
		
		for pos in _directions:
			var total = Vector3(0, 0, 0)
			for direction in _directions[pos]["directions"]:
				total.x += direction
			for corner in _directions[pos]["corners"]:
				total.y += corner
			_map.update(pos, total)
		_mask.set_shader_param("map", _map.get_map())


func _set_direction(pos : Vector2, direction : int):

	pos = pos.floor()

	if !_directions.has(pos):
		_directions[pos] = {"directions" : {}, "corners" : {}}
	
	if !_directions[pos]["directions"].has(direction):
		_directions[pos]["directions"][direction] = direction

	print("Adding " + str(pos) + " with direction " + str(direction))

	var corners = self._map_direction_to_corners(direction)
	for corner in corners:
		var offset = corners[corner]
		self._set_corners(offset + pos, corner)


func _set_corners(pos : Vector2, corner : int):

	if !_directions.has(pos):
		_directions[pos] = {"directions" : {}, "corners" : {}}

	if !_directions[pos]["corners"].has(corner):
		_directions[pos]["corners"][corner] = corner

	print("Adding " + str(pos) + " with corner " + str(corner))


func _get_direction(pos : Vector3, pos2 : Vector3) -> int:

	# for x in range(-1, 2):
	# 	for z in range(-1, 2):
	# 		var direction = Vector3(x, 0, z)
	# 		var angle = Vector3(0, 0, 1).signed_angle_to(direction, Vector3(0, 1, 0))
	# 		var id = str(angle).sha1_text().left(4)
	# 		print("Direction : " + str(direction))
	# 		print("SHA1 : " + str(id))


	var direction = Vector3(pos.x - pos2.x, 0, pos.z - pos2.z)
	var angle = Vector3(0, 0, -1).signed_angle_to(direction, Vector3(0, 1, 0))
	var id = str(angle).sha1_text().left(4)
	
	var directions = {
		"47e2" : 1, #NE
		"6be4" : 2, #E
		"dffa" : 4, #SE
		"9912" : 8, #S
		"b658" : 16, #SW
		"4ffb" : 32, #W
		"340d" : 64, #NW
		"4786" : 128 #N
	}
	return directions[id]


func _map_direction_to_corners(direction : int) -> Dictionary:
	
	var offset = {}
	match direction:
		8:
			offset = {2 : Vector2(0, 1), 1: Vector2(1, 0)}
		128:
			offset = {2 : Vector2(-1, 0), 1: Vector2(0, -1)}
		2:
			offset = {8 : Vector2(0, -1), 4: Vector2(1, 0)}
		32:
			offset = {8 : Vector2(-1, 0), 4: Vector2(0, 1)}
	return offset
