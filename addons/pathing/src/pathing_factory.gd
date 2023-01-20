class_name MUP_Pathing_Factory 

var _aStar : AStar
var _pathing_dimension

func _init(aStar : AStar, pathing_dimension):
	_aStar = aStar 
	_pathing_dimension = pathing_dimension


func create(world : MUW_World) -> MUP_Pathing:
	var pathing =  MUP_Pathing.new(_aStar, world, _pathing_dimension)
	var walkable_points = pathing.add_walkable_cells(world.get_non_walkable_points())
	pathing.connect_walkable_cells_diagonal(walkable_points)
	return pathing

