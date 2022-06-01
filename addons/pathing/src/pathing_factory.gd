class_name MUP_Pathing_Factory 

var _aStar : AStar

func _init(aStar : AStar):
	_aStar = aStar 


func create(world : MUP_World) -> MUP_Pathing:
	var pathing =  MUP_Pathing.new(_aStar, world)
	var walkable_points = pathing.add_walkable_cells(world.get_non_walkable_points())
	pathing.connect_walkable_cells_diagonal(walkable_points)
	return pathing

