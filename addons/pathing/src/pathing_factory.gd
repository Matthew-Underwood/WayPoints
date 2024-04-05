class_name MUP_Pathing_Factory 

var _tile_data : Dictionary
var _offset : Vector2

func _init(tile_data : Dictionary, offset = Vector2(0.5, 0.5)):
	_tile_data = tile_data
	_offset = offset


#TODO dedupe 2d and 3d methods
func create_2d(tilemap : TileMap) -> MUP_Pathing:
	var tiles = MUW_Tiles_Factory.new(_tile_data).create_2d(tilemap)
	var a_star = AStar.new()
	var pathing =  MUP_Pathing.new(a_star, tiles, _offset)
	var walkable_points = pathing.add_walkable_cells()
	pathing.connect_walkable_cells_diagonal(walkable_points)
	return pathing


func create_3d(cast_to, parent_node, points) -> MUP_Pathing:
	var tiles = MUW_Tiles_Factory.new(_tile_data).create_3d(cast_to, parent_node, points)
	var a_star = AStar.new()
	var pathing =  MUP_Pathing.new(a_star, tiles, _offset)
	var walkable_points = pathing.add_walkable_cells()
	pathing.connect_walkable_cells_diagonal(walkable_points)
	return pathing