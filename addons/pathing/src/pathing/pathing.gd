class_name Pathing

var _aStar : AStar
var _world : MU_World

func _init(aStar : AStar, world : MU_World):
	_aStar = aStar
	_world = world


# Loops through all cells within the world's bounds and
# adds all points to the _aStar, except the obstacles.
func addWalkableCells(obstacleList = []) -> Array:
	var pointsArray = []
	for y in range(_world.getSize().y):
		for x in range(_world.getSize().x):
			var point = Vector2(x, y)
			if point in obstacleList:
				continue

			pointsArray.append(point)
			# The AStar class references points with indices.
			# Using a function to calculate the index from a point's coordinates
			# ensures we always get the same index with the same input point.
			var pointIndex = _calculatePointIndex(point)
			# AStar works for both 2d and 3d, so we have to convert the point
			# coordinates from and to Vector3s.
			_aStar.add_point(pointIndex, Vector3(point.x, point.y, 0.0))
	return pointsArray


func isWalkable(point : Vector2) -> bool:
	var pointIndex = _calculatePointIndex(point)
	return _aStar.has_point(pointIndex)
	

# Once you added all points to the AStar node, you've got to connect them.
# The points don't have to be on a grid: you can use this class
# to create walkable graphs however you'd like.
# It's a little harder to code at first, but works for 2d, 3d,
# orthogonal grids, hex grids, tower defense games...
func connectWalkableCells(pointsArray : Array) -> void:
	for point in pointsArray:
		var pointIndex = _calculatePointIndex(point)
		# For every cell in the world, we check the one to the top, right.
		# left and bottom of it. If it's in the world and not an obstalce.
		# We connect the current point with it.
		var points_relative = PoolVector2Array([
			point + Vector2.RIGHT,
			point + Vector2.LEFT,
			point + Vector2.DOWN,
			point + Vector2.UP,
		])
		for pointRelative in points_relative:
			var pointRelativeIndex = _calculatePointIndex(pointRelative)
			if _world.is_out_of_bounds(pointRelative):
				continue
			if not _aStar.has_point(pointRelativeIndex):
				continue
			# Note the 3rd argument. It tells the _aStar that we want the
			# connection to be bilateral: from point A to B and B to A.
			# If you set this value to false, it becomes a one-way path.
			# As we loop through all points we can set it to false.
			_aStar.connect_points(pointIndex, pointRelativeIndex, false)


# This is a variation of the method above.
# It connects cells horizontally, vertically AND diagonally.
func connectWalkableCellsDiagonal(pointsArray : Array) -> void:
	for point in pointsArray:
		var pointIndex = _calculatePointIndex(point)
		for local_y in range(3):
			for local_x in range(3):
				var pointRelative = Vector2(point.x + local_x - 1, point.y + local_y - 1)
				var pointRelativeIndex = _calculatePointIndex(pointRelative)
				if pointRelative == point or _world.is_out_of_bounds(pointRelative):
					continue
				if not _aStar.has_point(pointRelativeIndex):
					continue
				_aStar.connect_points(pointIndex, pointRelativeIndex, true)


func getPath(pathStartPosition : Vector2, pathEndPosition : Vector2):
	var startPointIndex = _calculatePointIndex(pathStartPosition)
	var endPointIndex = _calculatePointIndex(pathEndPosition)
	if !_aStar.has_point(startPointIndex) or !_aStar.has_point(endPointIndex):
		return null
	return _aStar.get_point_path(startPointIndex, endPointIndex)


func _calculatePointIndex(point):
	return point.x + _world.getSize().x * point.y


