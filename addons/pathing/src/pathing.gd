class_name MUP_Pathing

var _aStar : AStar
var _world : MUP_World
var _pathing_dimension

func _init(aStar : AStar, world : MUP_World, pathing_dimension):
	_aStar = aStar
	_world = world
	_pathing_dimension = pathing_dimension


# Loops through all cells within the world's bounds and
# adds all points to the _aStar, except the obstacles.
func add_walkable_cells(obstacle_list = []) -> Array:
	var points_array = []
	for y in range(_world.get_size().y):
		for x in range(_world.get_size().x):
			var point = Vector2(x, y)
			if point in obstacle_list:
				continue
			points_array.append(point)
			# The AStar class references points with indices.
			# Using a function to calculate the index from a point's coordinates
			# ensures we always get the same index with the same input point.
			var point_index = _calculate_index(point)
			# AStar works for both 2d and 3d, so we have to convert the point
			# coordinates from and to Vector3s.
			_aStar.add_point(point_index, _pathing_dimension.point_to_position(point))
	return points_array


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
func connect_walkable_cells_diagonal(points_array : Array) -> void:
	for point in points_array:
		var point_index = _calculate_index(point)
		for local_y in range(3):
			for local_x in range(3):
				var relative = Vector2(point.x + local_x - 1, point.y + local_y - 1)
				var relative_index = _calculate_index(relative)
				if relative == point or _world.is_out_of_bounds(relative):
					continue
				if not _aStar.has_point(relative_index):
					continue
				_aStar.connect_points(point_index, relative_index, false)


func get_path(start_position : Vector3, end_position : Vector3):


	var start_index = _calculate_index(_pathing_dimension.position_to_point(start_position))
	var end_index = _calculate_index(_pathing_dimension.position_to_point(end_position))
	if !_aStar.has_point(start_index) or !_aStar.has_point(end_index):
		return null
	return _aStar.get_point_path(start_index, end_index)


func _calculate_index(point : Vector2) -> float:
	return point.x * _world.get_size().x + point.y
