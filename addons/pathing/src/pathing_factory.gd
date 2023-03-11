class_name MUP_Pathing_Factory 

var _aStar : AStar
var _world

func _init(aStar : AStar, world : MUW_World):
	_aStar = aStar 
	_world = world


func create() -> MUP_Pathing:
	var pathing =  MUP_Pathing.new(_aStar, _world)
	var walkable_points = pathing.add_walkable_cells(_world.get_non_walkable_points())
	pathing.connect_walkable_cells_diagonal(walkable_points)
	return pathing

