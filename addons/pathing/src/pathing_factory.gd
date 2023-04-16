class_name MUP_Pathing_Factory 

var _aStar : AStar
var _world : MUW_World
var _offset : Vector2

func _init(aStar : AStar, world : MUW_World, offset = Vector2(0.5, 0.5)):
	_aStar = aStar 
	_world = world
	_offset = offset


func create() -> MUP_Pathing:
	var pathing =  MUP_Pathing.new(_aStar, _world, _offset)
	var walkable_points = pathing.add_walkable_cells(_world.get_non_walkable_points())
	pathing.connect_walkable_cells_diagonal(walkable_points)
	return pathing

