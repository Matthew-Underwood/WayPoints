class_name MUW_Path_Structure

var _waypoint_data : Array
var _map : MUT_Texture_Map
var _directions : Dictionary
var _mask


func _init(map : MUT_Texture_Map, mask):
	_map = map
	_mask = mask


func send(data : Array):
	_set_path(data)


func _set_path(data : Array):

	_directions = {}
	if !data.empty():
		for id in range(data.size()):
			var previous_position = null
			var current_position = data[id]
			var next_position = null
			var previous_id = id - 1
			var next_id = id + 1

			if previous_id >= 0:
				previous_position = _get_normalised_relative_position(data[previous_id], current_position)

			if next_id < data.size():
				next_position = _get_normalised_relative_position(data[next_id], current_position)

			var relative_directions = {"previous" : previous_position, "next" : next_position}
			_set_direction(_normalise_position(current_position), relative_directions)
				
		for pos in _directions:
			var path_total = 0
			var corner_total = 0
			var col = Vector3.ZERO
			for id in _directions[pos]["paths"]:
				path_total += id
			for id in _directions[pos]["corners"]:
				corner_total += id

			if path_total == 256:
				col = Vector3(0, 1, corner_total)
			if path_total > 256:
				col = Vector3(path_total - 256, 1, corner_total)
			if path_total < 256:
				col = Vector3(path_total, 0, corner_total)
			_map.update(pos, col)
		_mask.set_shader_param("bezier_path_map", _map.get_map())
   

func _normalise_position(pos : Vector3):
	
	return Vector2(pos.x, pos.z).floor()


func _set_direction(pos : Vector2, relative_positions : Dictionary): 
	
	if !_directions.has(pos):
		_directions[pos] = {"paths" : {}, "corners" : {}}

	print("Relative positions " + str(relative_positions))

	match relative_positions:
		# 1,0 SE
		# -1,0 NE 
		# 0,1 SW
		# 0,-1 NW
		# linear north, south 
		{"previous" : Vector2(-1, -1), "next" : Vector2(1, 1)}:
			_directions[pos]["paths"][1] = 1
			_directions[pos]["paths"][256] = 256
			_apply_corners(pos, 1)
		{"previous" : Vector2(1, 1), "next" : Vector2(-1, -1)}:
			_directions[pos]["paths"][1] = 1
			_directions[pos]["paths"][256] = 256
			_apply_corners(pos, 1)
		{"previous" : null, "next" : Vector2(1, 1)}:
			_directions[pos]["paths"][16] = 16
			_directions[pos]["paths"][256] = 256
		{"previous" : Vector2(1, 1), "next" : null}:
			_directions[pos]["paths"][16] = 16
			_directions[pos]["paths"][256] = 256
		{"previous" : Vector2(-1, -1), "next" : null}: 
			_directions[pos]["paths"][16] = 16
			_directions[pos]["paths"][1] = 1
			_apply_corners(pos, 1)
		{"previous" : null, "next" : Vector2(-1, -1)}: 
			_directions[pos]["paths"][16] = 16
			_directions[pos]["paths"][1] = 1
			_apply_corners(pos, 1)

		# linear east, west 
		{"previous" : Vector2(1, -1), "next" : Vector2(-1, 1)}:
			_directions[pos]["paths"][64] = 64
			_directions[pos]["paths"][4] = 4 
			_apply_corners(pos, 4)
			_apply_corners(pos, 64)
		{"previous" : Vector2(-1, 1), "next" : Vector2(1, -1)}:
			_directions[pos]["paths"][64] = 64
			_directions[pos]["paths"][4] = 4 
			_apply_corners(pos, 64)
			_apply_corners(pos, 4)
		{"previous" : null, "next" : Vector2(-1, 1)}:
			_directions[pos]["paths"][64] = 64
			_directions[pos]["paths"][16] = 16
			_apply_corners(pos, 64)
		{"previous" : Vector2(-1, 1), "next" : null}:
			_directions[pos]["paths"][64] = 64
			_directions[pos]["paths"][16] = 16
			_apply_corners(pos, 64)
		{"previous" : Vector2(1, -1), "next" : null}: 
			_directions[pos]["paths"][4] = 4
			_directions[pos]["paths"][16] = 16
			_apply_corners(pos, 4)
		{"previous" : null, "next" : Vector2(1, -1)}: 
			_directions[pos]["paths"][4] = 4
			_directions[pos]["paths"][16] = 16
			_apply_corners(pos, 4)


		# linear south west, north east 
		{"previous" : Vector2(0, -1), "next" : Vector2(0, 1)}:
			_directions[pos]["paths"][2] = 2
			_directions[pos]["paths"][128] = 128
		{"previous" : Vector2(0, 1), "next" : Vector2(0, -1)}:
			_directions[pos]["paths"][2] = 2
			_directions[pos]["paths"][128] = 128
		{"previous" : null, "next" : Vector2(0, 1)}:
			_directions[pos]["paths"][16] = 16
			_directions[pos]["paths"][128] = 128
		{"previous" : Vector2(0, 1), "next" : null}: 
			_directions[pos]["paths"][16] = 16
			_directions[pos]["paths"][128] = 128
		{"previous" : Vector2(0, -1), "next" : null}: 
			_directions[pos]["paths"][2] = 2
			_directions[pos]["paths"][16] = 16
		{"previous" : null, "next" : Vector2(0, -1)}: 
			_directions[pos]["paths"][2] = 2
			_directions[pos]["paths"][16] = 16

		# linear south east, north west
		{"previous" : Vector2(-1, 0), "next" : Vector2(1, 0)}:
			_directions[pos]["paths"][8] = 8
			_directions[pos]["paths"][32] = 32
		{"previous" : Vector2(1, 0), "next" : Vector2(-1, 0)}:
			_directions[pos]["paths"][8] = 8
			_directions[pos]["paths"][32] = 32
		{"previous" : null, "next" : Vector2(1, 0)}:
			_directions[pos]["paths"][16] = 16
			_directions[pos]["paths"][32] = 32
		{"previous" : Vector2(1, 0), "next" : null}:
			_directions[pos]["paths"][16] = 16
			_directions[pos]["paths"][32] = 32
		{"previous" : Vector2(-1, 0), "next" : null}:
			_directions[pos]["paths"][8] = 8
			_directions[pos]["paths"][16] = 16
		{"previous" : null, "next" : Vector2(-1, 0)}:
			_directions[pos]["paths"][8] = 8
			_directions[pos]["paths"][16] = 16


		# bezier curve north west to south west
		{"previous" : Vector2(-1, 0), "next" : Vector2(0, 1)}:
			_directions[pos]["paths"][8] = 8
			_directions[pos]["paths"][128] = 128
		{"previous" : Vector2(0, 1), "next" : Vector2(-1, 0)}:
			_directions[pos]["paths"][8] = 8
			_directions[pos]["paths"][128] = 128

		# bezier curve north east to south east 
		{"previous" : Vector2(0, -1), "next" : Vector2(1, 0)}:
			_directions[pos]["paths"][2] = 2
			_directions[pos]["paths"][32] = 32
		{"previous" : Vector2(1, 0), "next" : Vector2(0, -1)}:
			_directions[pos]["paths"][2] = 2
			_directions[pos]["paths"][32] = 32

		# bezier curve north west to north east 
		{"previous" : Vector2(-1, 0), "next" : Vector2(0, -1)}:
			_directions[pos]["paths"][2] = 2
			_directions[pos]["paths"][8] = 8
		{"previous" : Vector2(0, -1), "next" : Vector2(-1, 0)}:
			_directions[pos]["paths"][2] = 2
			_directions[pos]["paths"][8] = 8

		# bezier curve south east to south west 
		{"previous" : Vector2(0, 1), "next" : Vector2(1, 0)}:
			_directions[pos]["paths"][32] = 32
			_directions[pos]["paths"][128] = 128
		{"previous" : Vector2(1, 0), "next" : Vector2(0, 1)}:
			_directions[pos]["paths"][32] = 32
			_directions[pos]["paths"][128] = 128
		
		# bezier curve north to east 
		{"previous" : Vector2(-1, -1), "next" : Vector2(1, -1)}:
			_directions[pos]["paths"][1] = 1
			_directions[pos]["paths"][4] = 4
			_apply_corners(pos, 1)
			_apply_corners(pos, 4)
		{"previous" : Vector2(1, -1), "next" : Vector2(-1, -1)}:
			_directions[pos]["paths"][1] = 1
			_directions[pos]["paths"][4] = 4
			_apply_corners(pos, 1)
			_apply_corners(pos, 4)

		# bezier curve east to south 
		{"previous" : Vector2(1, -1), "next" : Vector2(1, 1)}:
			_directions[pos]["paths"][4] = 4
			_directions[pos]["paths"][256] = 256 
			_apply_corners(pos, 4)
		{"previous" : Vector2(1, 1), "next" : Vector2(1, -1)}:
			_directions[pos]["paths"][4] = 4
			_directions[pos]["paths"][256] = 256 
			_apply_corners(pos, 4)

		# bezier curve south to west 
		{"previous" : Vector2(1, 1), "next" : Vector2(-1, 1)}:
			_directions[pos]["paths"][256] = 256
			_directions[pos]["paths"][64] = 64 
			_apply_corners(pos, 64)
		{"previous" : Vector2(-1, 1), "next" : Vector2(1, 1)}:
			_directions[pos]["paths"][256] = 256
			_directions[pos]["paths"][64] = 64 
			_apply_corners(pos, 64)

		# bezier curve west to north 
		{"previous" : Vector2(-1, 1), "next" : Vector2(-1, -1)}:
			_directions[pos]["paths"][64] = 64
			_directions[pos]["paths"][1] = 1 
			_apply_corners(pos, 64)
			_apply_corners(pos, 1)
		{"previous" : Vector2(-1, -1), "next" : Vector2(-1, 1)}:
			_directions[pos]["paths"][64] = 64
			_directions[pos]["paths"][1] = 1
			_apply_corners(pos, 1)
			_apply_corners(pos, 64)

		# bezier curve north to south east
		{"previous" : Vector2(-1, -1), "next" : Vector2(1, 0)}:
			_directions[pos]["paths"][1] = 1
			_directions[pos]["paths"][32] = 32 
			_apply_corners(pos, 1)
		{"previous" : Vector2(1, 0), "next" : Vector2(-1, -1)}:
			_directions[pos]["paths"][1] = 1
			_directions[pos]["paths"][32] = 32 
			_apply_corners(pos, 1)

		# bezier curve north east to south 
		{"previous" : Vector2(0, -1), "next" : Vector2(1, 1)}:
			_directions[pos]["paths"][2] = 2
			_directions[pos]["paths"][256] = 256 
		{"previous" : Vector2(1, 1), "next" : Vector2(0, -1)}:
			_directions[pos]["paths"][2] = 2
			_directions[pos]["paths"][256] = 256 

		# bezier curve east to south west 
		{"previous" : Vector2(1, -1), "next" : Vector2(0, 1)}:
			_directions[pos]["paths"][4] = 4
			_directions[pos]["paths"][128] = 128 
			_apply_corners(pos, 4)
		{"previous" : Vector2(0, 1), "next" : Vector2(1, -1)}:
			_directions[pos]["paths"][4] = 4
			_directions[pos]["paths"][128] = 128 
			_apply_corners(pos, 4)

		# bezier curve south east to west 
		{"previous" : Vector2(1, 0), "next" : Vector2(-1, 1)}:
			_directions[pos]["paths"][32] = 32
			_directions[pos]["paths"][64] = 64 
			_apply_corners(pos, 64)
		{"previous" : Vector2(-1, 1), "next" : Vector2(1, 0)}:
			_directions[pos]["paths"][32] = 32
			_directions[pos]["paths"][64] = 64 
			_apply_corners(pos, 64)

		# bezier curve south to north west 
		{"previous" : Vector2(1, 1), "next" : Vector2(-1, 0)}:
			_directions[pos]["paths"][256] = 256
			_directions[pos]["paths"][8] = 8 
		{"previous" : Vector2(-1, 0), "next" : Vector2(1, 1)}:
			_directions[pos]["paths"][256] = 256
			_directions[pos]["paths"][8] = 8 

		# bezier curve south west to north
		{"previous" : Vector2(0, 1), "next" : Vector2(-1, -1)}:
			_directions[pos]["paths"][128] = 128
			_directions[pos]["paths"][1] = 1 
			_apply_corners(pos, 1)
		{"previous" : Vector2(-1, -1), "next" : Vector2(0, 1)}:
			_directions[pos]["paths"][128] = 128
			_directions[pos]["paths"][1] = 1 
			_apply_corners(pos, 1)

		# bezier curve west to north east 
		{"previous" : Vector2(-1, 1), "next" : Vector2(0, -1)}:
			_directions[pos]["paths"][64] = 64
			_directions[pos]["paths"][2] = 2 
			_apply_corners(pos, 64)
		{"previous" : Vector2(0, -1), "next" : Vector2(-1, 1)}:
			_directions[pos]["paths"][64] = 64
			_directions[pos]["paths"][2] = 2 
			_apply_corners(pos, 64)

		# bezier curve north west to east
		{"previous" : Vector2(-1, 0), "next" : Vector2(1, -1)}:
			_directions[pos]["paths"][8] = 8
			_directions[pos]["paths"][4] = 4 
			_apply_corners(pos, 4)
		{"previous" : Vector2(1, -1), "next" : Vector2(-1, 0)}:
			_directions[pos]["paths"][8] = 8
			_directions[pos]["paths"][4] = 4 
			_apply_corners(pos, 4)

		# bezier curve north to north east
		{"previous" : Vector2(-1, -1), "next" : Vector2(0, -1)}:
			_directions[pos]["paths"][1] = 1
			_directions[pos]["paths"][2] = 2 
			_apply_corners(pos, 1)
		{"previous" : Vector2(0, -1), "next" : Vector2(-1, -1)}:
			_directions[pos]["paths"][1] = 1
			_directions[pos]["paths"][2] = 2 
			_apply_corners(pos, 1)

		# bezier curve north east to east
		{"previous" : Vector2(0, -1), "next" : Vector2(1, -1)}:
			_directions[pos]["paths"][2] = 2
			_directions[pos]["paths"][4] = 4
			_apply_corners(pos, 4)
		{"previous" : Vector2(1, -1), "next" : Vector2(0, -1)}:
			_directions[pos]["paths"][2] = 2
			_directions[pos]["paths"][4] = 4
			_apply_corners(pos, 4)

		# bezier curve east to south east
		{"previous" : Vector2(1, -1), "next" : Vector2(1, 0)}:
			_directions[pos]["paths"][4] = 4
			_directions[pos]["paths"][32] = 32
			_apply_corners(pos, 4)
		{"previous" : Vector2(1, 0), "next" : Vector2(1, -1)}:
			_directions[pos]["paths"][4] = 4
			_directions[pos]["paths"][32] = 32
			_apply_corners(pos, 4)

		# bezier curve south east to south
		{"previous" : Vector2(1, 0), "next" : Vector2(1, 1)}:
			_directions[pos]["paths"][32] = 32
			_directions[pos]["paths"][256] = 256
		{"previous" : Vector2(1, 1), "next" : Vector2(1, 0)}:
			_directions[pos]["paths"][32] = 32
			_directions[pos]["paths"][256] = 256

		# bezier curve south to south west 
		{"previous" : Vector2(1, 1), "next" : Vector2(0, 1)}:
			_directions[pos]["paths"][256] = 256
			_directions[pos]["paths"][128] = 128
		{"previous" : Vector2(0, 1), "next" : Vector2(1, 1)}:
			_directions[pos]["paths"][256] = 256
			_directions[pos]["paths"][128] = 128

		# bezier curve south west to west 
		{"previous" : Vector2(0, 1), "next" : Vector2(-1, 1)}:
			_directions[pos]["paths"][128] = 128
			_directions[pos]["paths"][64] = 64
			_apply_corners(pos, 64)
		{"previous" : Vector2(-1, 1), "next" : Vector2(0, 1)}:
			_directions[pos]["paths"][128] = 128
			_directions[pos]["paths"][64] = 64
			_apply_corners(pos, 64)

		# bezier curve west to north west 
		{"previous" : Vector2(-1, 1), "next" : Vector2(-1, 0)}:
			_directions[pos]["paths"][64] = 64
			_directions[pos]["paths"][8] = 8
			_apply_corners(pos, 64)
		{"previous" : Vector2(-1, 0), "next" : Vector2(-1, 1)}:
			_directions[pos]["paths"][64] = 64
			_directions[pos]["paths"][8] = 8
			_apply_corners(pos, 64)
		
		# bezier curve north west to north 
		{"previous" : Vector2(-1, 0), "next" : Vector2(-1, -1)}:
			_directions[pos]["paths"][8] = 8
			_directions[pos]["paths"][1] = 1
			_apply_corners(pos, 1)
		{"previous" : Vector2(-1, -1), "next" : Vector2(-1, 0)}:
			_directions[pos]["paths"][8] = 8
			_directions[pos]["paths"][1] = 1
			_apply_corners(pos, 1)


func _apply_corners(pos : Vector2, id : int):

	var relative_directions = {}
	match id:
		1:
			relative_directions[Vector2(-1, 0)] = 4
			relative_directions[Vector2(0, -1)] = 8
		4:
			relative_directions[Vector2(0, -1)] = 2
			relative_directions[Vector2(1, 0)] = 1
		64:
			relative_directions[Vector2(0, 1)] = 1
			relative_directions[Vector2(-1, 0)] = 2
		256:
			relative_directions[Vector2(1, 0)] = 4
			relative_directions[Vector2(0, 1)] = 8


	for relative_direction in relative_directions:
		var absolute_pos = pos + relative_direction
		var direction_id = relative_directions[relative_direction]

		if !_directions.has(absolute_pos):
			_directions[absolute_pos] = {"paths" : {}, "corners" : {}}
		_directions[absolute_pos]["corners"][direction_id] = direction_id
			

func _get_relative_position(pos1 : Vector2, pos2 : Vector2):

	return  pos1 - pos2


func _get_normalised_relative_position(pos : Vector3, pos2 : Vector3):

	var normalised_position = _normalise_position(pos)
	var normalised_position2 = _normalise_position(pos2)

	return _get_relative_position(normalised_position, normalised_position2)
	
