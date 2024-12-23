class_name MUW_Path_Structure

var _waypoint_data : Array
var _map : MUT_Texture_Map
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



func _flatten(waypoint_data : Array):
	var flattened_data = []
	for waypoint_id in range(waypoint_data.size()):
		var waypoint_path_data = waypoint_data[waypoint_id].get_path()
		var points = _normalise_points(waypoint_path_data)
		var points_size = points.size()
		for point_id in range(points_size):
			if point_id == points_size - 1 && waypoint_id != waypoint_data.size() - 1:
				continue
			flattened_data.append(points[point_id])
	return flattened_data


func _set_path():

	_directions = {}
	if !_waypoint_data.empty():
		var flattened_data = _flatten(_waypoint_data)
		for id in range(flattened_data.size()):
			var previous_position = null
			var current_position = flattened_data[id]
			var next_position = null
			var previous_id = id - 1
			var next_id = id + 1

			if previous_id >= 0:
				previous_position = _get_normalised_relative_position(flattened_data[previous_id], current_position)

			if next_id < flattened_data.size():
				next_position = _get_normalised_relative_position(flattened_data[next_id], current_position)

			var relative_directions = {"previous" : previous_position, "next" : next_position}
			_set_direction(_normalise_position(current_position), relative_directions)
				
		for pos in _directions:
			var linear_total = 0
			var right_angle_total = 0
			var obtuse_total = 0

			for id in _directions[pos]["linear"]:
				linear_total += _directions[pos]["linear"][id]
			for id in _directions[pos]["right_angle"]:
				right_angle_total += _directions[pos]["right_angle"][id]
			for id in _directions[pos]["obtuse"]:
				obtuse_total += _directions[pos]["obtuse"][id]
			_map.update(pos, Vector3(linear_total, right_angle_total, obtuse_total))
		_mask.set_shader_param("bezier_path_map", _map.get_map())
   

func _normalise_points(points : PoolVector3Array) -> PoolVector3Array:
	
	var normalised_points = PoolVector3Array()
	for id in points:
		if Vector2(id.x, id.z).floor() + Vector2(0.5, 0.5) == Vector2(id.x, id.z):
			normalised_points.push_back(id)
	return normalised_points


func _normalise_position(pos : Vector3):
	
	return Vector2(pos.x, pos.z).floor()


func _set_direction(pos : Vector2, relative_positions : Dictionary): 

	if !_directions.has(pos):
		_directions[pos] = {"linear" : {}, "right_angle" : {}, "obtuse" : {}, "acute" : {}}
	print("relative pos " + str(relative_positions))
	var linear_half_id = _get_id_linear_half_line(relative_positions)
	print("linear half id: " + str(linear_half_id))
	var linear_id = _get_id_linear_line(relative_positions)
	print("linear id: " + str(linear_id))
	var bezier_obtuse_id = _get_id_bezier_obtuse(relative_positions)
	print("linear obtuse id: " + str(bezier_obtuse_id))
	var bezier_right_angle_id = _get_id_bezier_right_angle(relative_positions)
	print("linear right angle id: " + str(bezier_right_angle_id))
	var bezier_acute_id = _get_id_bezier_acute(relative_positions)
	print("linear acute id: " + str(bezier_acute_id))

	if linear_half_id != 0: 
		_directions[pos]["linear"][linear_half_id] = linear_half_id

	if linear_id == 68: 
		_directions[pos]["linear"][4] = 4
		_directions[pos]["linear"][64] = 64

	if linear_id == 34: 
		_directions[pos]["linear"][2] = 2
		_directions[pos]["linear"][32] = 32

	if linear_id == 17: 
		_directions[pos]["linear"][1] = 1
		_directions[pos]["linear"][16] = 16

	if linear_id == 136: 
		_directions[pos]["linear"][8] = 8
		_directions[pos]["linear"][128] = 128

	if bezier_right_angle_id != 0:
		_directions[pos]["right_angle"][bezier_right_angle_id] = bezier_right_angle_id

	if bezier_obtuse_id != 0: 
		_directions[pos]["obtuse"][bezier_obtuse_id] = bezier_obtuse_id

	if bezier_acute_id != 0: 
		_directions[pos]["acute"][bezier_acute_id] = bezier_acute_id


func _get_id_linear_half_line(relative_pos : Dictionary):

	var id = 0
	print(relative_pos)
	match relative_pos:
		#linear half line
		{"next" : Vector2(0, -1), "previous" : null}:
			id = 1
		{"next" : null, "previous" : Vector2(0, -1)}:
			id = 1
		{"next" : Vector2(1, 1), "previous" : null}:
			id = 2
		{"next" : null, "previous" : Vector2(1, 1)}:
			id = 2
		{"next" : null, "previous" : Vector2(0, 1)}:
			id = 16 
		{"next" : Vector2(0, 1), "previous" : null}:
			id = 16 
		{"next" : Vector2(-1, 1), "previous" : null}:
			id = 8
		{"next" : null , "previous" : Vector2(-1, 1)}:
			id = 8
		{"next" : Vector2(-1, -1), "previous" : null}:
			id = 32
		{"next" : null, "previous" : Vector2(-1, -1)}:
			id = 32
		{"next" : Vector2(1, 0), "previous" : null}:
			id = 4
		{"next" : null, "previous" : Vector2(1, 0)}:
			id = 4
		{"next" : null, "previous" : Vector2(-1, 0)}:
			id = 64
		{"next" : Vector2(-1, 0), "previous" : null}: 
			id = 65
		{"next" : Vector2(1, -1), "previous" : null}:
			id = 128
		{"next" : null, "previous" : Vector2(1, -1)}:
			id = 128

	return id


func _get_id_bezier_acute(relative_pos : Dictionary):

    var id = 0
	match relative_pos:
		{"previous" : Vector2(0, 0), "next" : Vector2(0.5, 0)}, {"next" : Vector2(0, 0), "previous" : Vector2(0.5, 0)}:
            id = 1
		{"previous" : Vector2(0.5, 0), "next" : Vector2(1, 0)}, {"next" : Vector2(0.5, 0), "previous" : Vector2(1, 0)}:
            id = 2
		{"previous" : Vector2(1, 0), "next" : Vector2(1, 0.5)}, {"next" : Vector2(1, 0), "previous" : Vector2(1, 0.5)}:
            id = 4


func _get_id_linear_line(relative_pos : Dictionary):

	var id = 0
	match relative_pos:
		{"previous" : Vector2(-1, 0), "next" : Vector2(1, 0)}, {"next" : Vector2(-1, 0), "previous" : Vector2(1, 0)}:
			id = 68
		{"previous" : Vector2(-1, -1), "next" : Vector2(1, 1)}, {"next" : Vector2(-1, -1), "previous" : Vector2(1, 1)}:
			id = 34
		{"previous" : Vector2(0, -1), "next" : Vector2(0, 1)}, {"next" : Vector2(0, -1), "previous" : Vector2(0, 1)}:
			id = 17
		{"previous" : Vector2(1, -1), "next" : Vector2(-1, 1)}, {"next" : Vector2(1, -1), "previous" : Vector2(-1, 1)}:
			id = 136

	return id


func _get_id_bezier_obtuse(relative_pos : Dictionary):

	var id = 0
	match relative_pos:
		# bezier slight curve
		{"previous" : Vector2(-1, 0), "next" : Vector2(1, 1)}, {"next" : Vector2(-1, 0), "previous" : Vector2(1, 1)}:
			id = 128
		{"previous" : Vector2(0, -1), "next" : Vector2(-1, 1)}, {"next" : Vector2(0, -1), "previous" : Vector2(-1, 1)}:
			id = 2
		{"previous" : Vector2(1, 0), "next" : Vector2(-1, -1)}, {"next" : Vector2(1, 0), "previous" : Vector2(-1, -1)}:
			id = 4
		{"previous" : Vector2(0, 1), "next" : Vector2(1, -1)}, {"next" : Vector2(0, 1), "previous" : Vector2(1, -1)}:
			id = 8
		{"previous" : Vector2(-1, 0), "next" : Vector2(1, -1)}, {"next" : Vector2(-1, 0), "previous" : Vector2(1, -1)}:
			id = 16
		{"previous" : Vector2(0, -1), "next" : Vector2(1, 1)}, {"next" : Vector2(0, -1), "previous" : Vector2(1, 1)}:
			id = 1
		{"previous" : Vector2(1, 0), "next" : Vector2(-1, 1)}, {"next" : Vector2(1, 0), "previous" : Vector2(-1, 1)}:
			id = 64
		{"previous" : Vector2(0, 1), "next" : Vector2(-1, -1)}, {"next" : Vector2(0, 1), "previous" : Vector2(-1, -1)}:
			id = 32

	return id


func _get_id_bezier_right_angle(relative_pos : Dictionary):

	var id = 0
	match relative_pos:
		# bezier sharp curve
		{"previous" : Vector2(-1, 0), "next" : Vector2(0, 1)}, {"next" : Vector2(-1, 0), "previous" : Vector2(0, 1)}:
			id = 2
		{"previous" : Vector2(0, 1), "next" : Vector2(1, 0)}, {"previous" : Vector2(1, 0), "next" : Vector2(0, 1)}: 
			id = 4
		{"previous" : Vector2(0, -1), "next" : Vector2(-1, 0)}, {"next" : Vector2(0, -1), "previous" : Vector2(-1, 0)}:
			id = 64
		{"previous" : Vector2(1, 0), "next" : Vector2(0, -1)}, {"next" : Vector2(1, 0), "previous" : Vector2(0, -1)}:
			id = 1
		{"previous" : Vector2(1, -1), "next" : Vector2(1, 1)}, {"next" : Vector2(1, -1), "previous" : Vector2(1, 1)}:
			id = 16
		{"previous" : Vector2(-1, 1), "next" : Vector2(1, 1)}, {"next" : Vector2(-1, 1), "previous" : Vector2(1, 1)}:
			id = 32
		{"previous" : Vector2(-1, 1), "next" : Vector2(-1, -1)}, {"next" : Vector2(-1, 1), "previous" : Vector2(-1, -1)}:
			id = 8
		{"previous" : Vector2(-1, -1), "next" : Vector2(1, -1)}, {"previous" : Vector2(-1, -1), "next" : Vector2(1, -1)}:
			id = 128

	return id 
	  

func _get_relative_position(pos1 : Vector2, pos2 : Vector2):

	return  pos1 - pos2


func _get_normalised_relative_position(pos : Vector3, pos2 : Vector3):

	var normalised_position = _normalise_position(pos)
	var normalised_position2 = _normalise_position(pos2)

	return _get_relative_position(normalised_position, normalised_position2)
	
