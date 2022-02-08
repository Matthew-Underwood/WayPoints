class_name PathingFactory 



func create(world) -> Pathing:
	var pathing = load("res://addons/pathing/src/pathing/pathing.gd")
	var aStar = AStar.new()
	pathing = pathing.new(aStar, world)
	var non_walkable_points = world.get_non_walkable_points()
	var walkableTiles = pathing.addWalkableCells(non_walkable_points)
	pathing.connectWalkableCellsDiagonal(walkableTiles)
	return pathing
