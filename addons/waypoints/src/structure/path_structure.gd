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
			var col = Vector3.ZERO
			if _directions[pos] == 256:
				col = Vector3(0, 1, 0)
			if _directions[pos] > 256:
				col = Vector3(_directions[pos] - 256, 1, 0)
			if _directions[pos] < 256:
				col = Vector3(_directions[pos], 0, 0)
			_map.update(pos, col)
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
	
	var id = 0
	if !_directions.has(pos):
		_directions[pos] = 0

	print("Relative positions " + str(relative_positions))

	match relative_positions:

		# linear north, south 
		{"previous" : Vector2(-1, -1), "next" : Vector2(1, 1)}:
			id = 1 + 256
		{"previous" : Vector2(1, 1), "next" : Vector2(-1, -1)}:
			id = 1 + 256
		{"previous" : null, "next" : Vector2(1, 1)}:
			id = 16 + 256
		{"previous" : Vector2(1, 1), "next" : null}:
			id = 16 + 256
		{"previous" : Vector2(-1, -1), "next" : null}: 
			id = 16 + 1
		{"previous" : null, "next" : Vector2(-1, -1)}: 
			id = 16 + 1

		# linear east, west 
		{"previous" : Vector2(1, -1), "next" : Vector2(-1, 1)}:
			id = 64 + 4 
		{"previous" : Vector2(-1, 1), "next" : Vector2(1, -1)}:
			id = 64 + 4 
		{"previous" : null, "next" : Vector2(-1, 1)}:
			id = 64 + 16
		{"previous" : Vector2(-1, 1), "next" : null}:
			id = 64 + 16
		{"previous" : Vector2(1, -1), "next" : null}: 
			id = 4 + 16
		{"previous" : null, "next" : Vector2(1, -1)}: 
			id = 4 + 16


		# linear south west, north east 
		{"previous" : Vector2(0, -1), "next" : Vector2(0, 1)}:
			id = 2 + 128
		{"previous" : Vector2(0, 1), "next" : Vector2(0, -1)}:
			id = 2 + 128
		{"previous" : null, "next" : Vector2(0, 1)}:
			id = 16 + 128
		{"previous" : Vector2(0, 1), "next" : null}: 
			id = 16 + 128
		{"previous" : Vector2(0, -1), "next" : null}: 
			id = 2 + 16
		{"previous" : null, "next" : Vector2(0, -1)}: 
			id = 2 + 16

		# linear south east, north west
		{"previous" : Vector2(-1, 0), "next" : Vector2(1, 0)}:
			id = 8 + 32
		{"previous" : Vector2(1, 0), "next" : Vector2(-1, 0)}:
			id = 8 + 32
		{"previous" : null, "next" : Vector2(1, 0)}:
			id = 16 + 32
		{"previous" : Vector2(1, 0), "next" : null}:
			id = 16 + 32
		{"previous" : Vector2(-1, 0), "next" : null}:
			id = 8 + 16
		{"previous" : null, "next" : Vector2(-1, 0)}:
			id = 8 + 16


		# bezier curve north west to south west
		{"previous" : Vector2(-1, 0), "next" : Vector2(0, 1)}:
			id = 8 + 128
		{"previous" : Vector2(0, 1), "next" : Vector2(-1, 0)}:
			id = 8 + 128

		# bezier curve north east to south east 
		{"previous" : Vector2(0, -1), "next" : Vector2(1, 0)}:
			id = 2 + 32
		{"previous" : Vector2(1, 0), "next" : Vector2(0, -1)}:
			id = 2 + 32

		# bezier curve north west to north east 
		{"previous" : Vector2(-1, 0), "next" : Vector2(0, -1)}:
			id = 2 + 8
		{"previous" : Vector2(0, -1), "next" : Vector2(-1, 0)}:
			id = 2 + 8

		# bezier curve south east to south west 
		{"previous" : Vector2(0, 1), "next" : Vector2(1, 0)}:
			id = 32 + 128
		{"previous" : Vector2(1, 0), "next" : Vector2(0, 1)}:
			id = 32 + 128
		
		# bezier curve north to east 
		{"previous" : Vector2(-1, -1), "next" : Vector2(1, -1)}:
			id = 1 + 4
		{"previous" : Vector2(1, -1), "next" : Vector2(-1, -1)}:
			id = 1 + 4

		# bezier curve east to south 
		{"previous" : Vector2(1, -1), "next" : Vector2(1, 1)}:
			id = 4 + 256 
		{"previous" : Vector2(1, 1), "next" : Vector2(1, -1)}:
			id = 4 + 256 

		# bezier curve south to west 
		{"previous" : Vector2(1, 1), "next" : Vector2(-1, 1)}:
			id = 256 + 64 
		{"previous" : Vector2(-1, 1), "next" : Vector2(1, 1)}:
			id = 256 + 64 

		# bezier curve west to north 
		{"previous" : Vector2(-1, 1), "next" : Vector2(-1, -1)}:
			id = 64 + 1 
		{"previous" : Vector2(-1, -1), "next" : Vector2(-1, 1)}:
			id = 64 + 1

		# bezier curve north to south east
		{"previous" : Vector2(-1, -1), "next" : Vector2(1, 0)}:
			id = 1 + 32 
		{"previous" : Vector2(1, 0), "next" : Vector2(-1, -1)}:
			id = 1 + 32 

		# bezier curve north east to south 
		{"previous" : Vector2(0, -1), "next" : Vector2(1, 1)}:
			id = 2 + 256 
		{"previous" : Vector2(1, 1), "next" : Vector2(0, -1)}:
			id = 2 + 256 

		# bezier curve east to south west 
		{"previous" : Vector2(1, -1), "next" : Vector2(0, 1)}:
			id = 4 + 128 
		{"previous" : Vector2(0, 1), "next" : Vector2(1, -1)}:
			id = 4 + 128 

		# bezier curve south east to west 
		{"previous" : Vector2(1, 0), "next" : Vector2(-1, 1)}:
			id = 32 + 64 
		{"previous" : Vector2(-1, 1), "next" : Vector2(1, 0)}:
			id = 33 + 64 

		# bezier curve south to north west 
		{"previous" : Vector2(1, 1), "next" : Vector2(-1, 0)}:
			id = 256 + 8 
		{"previous" : Vector2(-1, 0), "next" : Vector2(1, 1)}:
			id = 256 + 8 

		# bezier curve south west to north
		{"previous" : Vector2(0, 1), "next" : Vector2(-1, -1)}:
			id = 128 + 1 
		{"previous" : Vector2(-1, -1), "next" : Vector2(0, 1)}:
			id = 128 + 1 

		# bezier curve west to north east 
		{"previous" : Vector2(-1, 1), "next" : Vector2(0, -1)}:
			id = 64 + 2 
		{"previous" : Vector2(0, -1), "next" : Vector2(-1, 1)}:
			id = 64 + 2 

		# bezier curve north west to east
		{"previous" : Vector2(-1, 0), "next" : Vector2(1, -1)}:
			id = 8 + 4 
		{"previous" : Vector2(1, -1), "next" : Vector2(-1, 0)}:
			id = 8 + 4 

		# bezier curve north to north east
		{"previous" : Vector2(-1, -1), "next" : Vector2(0, -1)}:
			id = 1 + 2 
		{"previous" : Vector2(0, -1), "next" : Vector2(-1, -1)}:
			id = 1 + 2 

		# bezier curve north east to east
		{"previous" : Vector2(0, -1), "next" : Vector2(1, -1)}:
			id = 2 + 4
		{"previous" : Vector2(1, -1), "next" : Vector2(0, -1)}:
			id = 2 + 4

		# bezier curve east to south east
		{"previous" : Vector2(1, -1), "next" : Vector2(1, 0)}:
			id = 4 + 32
		{"previous" : Vector2(1, 0), "next" : Vector2(1, -1)}:
			id = 4 + 32

		# bezier curve south east to south
		{"previous" : Vector2(1, 0), "next" : Vector2(1, 1)}:
			id = 32 + 256
		{"previous" : Vector2(1, 1), "next" : Vector2(1, 0)}:
			id = 32 + 256

		# bezier curve south to south west 
		{"previous" : Vector2(1, 1), "next" : Vector2(0, 1)}:
			id = 256 + 128
		{"previous" : Vector2(0, 1), "next" : Vector2(1, 1)}:
			id = 256 + 128

		# bezier curve south west to west 
		{"previous" : Vector2(0, 1), "next" : Vector2(-1, 1)}:
			id = 128 + 64
		{"previous" : Vector2(-1, 1), "next" : Vector2(0, 1)}:
			id = 128 + 64

		# bezier curve west to north west 
		{"previous" : Vector2(-1, 1), "next" : Vector2(-1, 0)}:
			id = 64 + 8
		{"previous" : Vector2(-1, 0), "next" : Vector2(-1, 1)}:
			id = 64 + 8
		
		# bezier curve north west to north 
		{"previous" : Vector2(-1, 0), "next" : Vector2(-1, -1)}:
			id = 8 + 1
		{"previous" : Vector2(-1, -1), "next" : Vector2(-1, 0)}:
			id = 8 + 1
	_directions[pos] = id


func _get_relative_position(pos1 : Vector2, pos2 : Vector2):

	return  pos1 - pos2


func _get_normalised_relative_position(pos : Vector3, pos2 : Vector3):

	var normalised_position = _normalise_position(pos)
	var normalised_position2 = _normalise_position(pos2)

	return _get_relative_position(normalised_position, normalised_position2)
	
