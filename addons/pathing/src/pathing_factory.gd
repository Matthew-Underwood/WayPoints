class_name MUP_Pathing_Factory 

var _tiles : MUW_Tiles
var _offset : Vector2

func _init(tiles : MUW_Tiles, offset = Vector2(0.5, 0.5)):
	_tiles = tiles
	_offset = offset


func create() -> MUP_Pathing:

	var pathing =  MUP_Pathing.new(AStar.new(), _tiles, _offset)
	var walkable_points = pathing.add_walkable_cells()
	pathing.connect_walkable_cells_diagonal(walkable_points)
	return pathing
