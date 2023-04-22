class_name MUP_Pathing

var _aStar : AStar
var _world : MUW_World
var _offset : Vector2

func _init(aStar : AStar, world : MUW_World, offset : Vector2):
	_aStar = aStar
	_world = world
	_offset = offset


# Loops through all cells within the world's bounds and
# adds all points to the _aStar, except the obstacles.
func add_walkable_cells(obstacle_list = []) -> Array:
	var tile_positions = []
	var tiles = _world.get_tiles().get_all()
	for tile_pos in tiles:
		if tile_pos in obstacle_list:
			continue
		tile_positions.append(tile_pos)
		# The AStar class references points with indices.
		# Using a function to calculate the index from a point's coordinates
		# ensures we always get the same index with the same input point.
		# AStar works for both 2d and 3d, so we have to convert the point
		# coordinates from and to Vector3s.
		for tile_world_position in tiles[tile_pos]["world_positions"]:
			var point_index = _calculate_index(tile_world_position)
			if !_aStar.has_point(point_index):
				var pathing_position = tiles[tile_pos]["world_positions"][tile_world_position]
				_aStar.add_point(point_index, pathing_position)
	return tile_positions


func is_walkable(point : Vector2) -> bool:
	var point_index = _calculate_index(point)
	return _aStar.has_point(point_index)
	

# Once you added all points to the AStar node, you've got to connect them.
# The points don't have to be on a grid: you can use this class
# to create walkable graphs however you'd like.
# It's a little harder to code at first, but works for 2d, 3d,
# orthogonal grids, hex grids, tower defense games...
func connect_walkable_cells(points_array : Array) -> void:
	for point in points_array:
		var point_index = _calculate_index(point)
		# For every cell in the world, we check the one to the top, right.
		# left and bottom of it. If it's in the world and not an obstalce.
		# We connect the current point with it.
		var points_relative = PoolVector2Array([
			point + Vector2.RIGHT,
			point + Vector2.LEFT,
			point + Vector2.DOWN,
			point + Vector2.UP,
		])
		for relative in points_relative:
			var relative_index = _calculate_index(relative)
			if _world.is_out_of_bounds(relative):
				continue
			if not _aStar.has_point(relative_index):
				continue
			# Note the 3rd argument. It tells the _aStar that we want the
			# connection to be bilateral: from point A to B and B to A.
			# If you set this value to false, it becomes a one-way path.
			# As we loop through all points we can set it to false.
			_aStar.connect_points(point_index, relative_index, false)


# This is a variation of the method above.
# It connects cells horizontally, vertically AND diagonally.
func connect_walkable_cells_diagonal(tile_positions : Array) -> void:

	for tile_position in tile_positions:
		tile_position = tile_position + _offset
		for local_y in range(3):
			for local_x in range(3):
				var point_index = _calculate_index(tile_position)
				var relative_position_offset = Vector2(local_x - 1, local_y - 1)
				var relative_position = tile_position + relative_position_offset
				var relative_point_index = _calculate_index(relative_position)

				var local_relative_point_position = tile_position + (relative_position_offset / 2)
				var local_relative_point_index = _calculate_index(local_relative_point_position)
				
				if relative_position == tile_position or _world.is_out_of_bounds(relative_position):
					continue
				if !_aStar.has_point(relative_point_index):
					continue
				if _aStar.has_point(local_relative_point_index):
					_aStar.connect_points(point_index, local_relative_point_index, false)
					point_index = local_relative_point_index
				_aStar.connect_points(point_index, relative_point_index, false)


func get_path(start_position : Vector2, end_position : Vector2) -> PoolVector3Array:

	var start_index = _calculate_index(start_position + _offset)
	var end_index = _calculate_index(end_position + _offset)
	#TODO get rid of this? We should never have a case where has_point is false
	#if !_aStar.has_point(start_index) or !_aStar.has_point(end_index):
	#	return null
	return _aStar.get_point_path(start_index, end_index)


func _calculate_index(point : Vector2) -> float:
	return point.x * pow(8, 2) + point.y * pow(128, 2)
