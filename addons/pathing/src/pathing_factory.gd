class_name MUP_Pathing_Factory 

var _offset : Vector2
var _tiles : MUW_Tiles

func _init(tiles : MUW_Tiles, offset = Vector2(0.5, 0.5)):
	_tiles = tiles
	_offset = offset


func create() -> MUP_Pathing:
	var a_star = AStar.new()
	var pathing =  MUP_Pathing.new(a_star, _tiles, _offset)
	var walkable_points = pathing.add_walkable_cells()
	pathing.connect_walkable_cells_diagonal(walkable_points)
	return pathing

