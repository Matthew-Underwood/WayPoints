class_name MUP_Pathing_Factory 

var _aStar : AStar

func _init(aStar : AStar):
	_aStar = aStar 


func create(world : MUP_World) -> MUP_Pathing:
	return  MUP_Pathing.new(_aStar, world)
