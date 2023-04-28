class_name MUW_Tiles_Factory

var _tile_data : Dictionary

func _init(tile_data : Dictionary):
	_tile_data = tile_data


func create_2d(tilemap : TileMap) -> MUW_Tiles:

	var tile_processor = MUW_Tiles_Processor_Factory.new().create_2d(tilemap)
	return _build_tiles(tile_processor)


func create_3d(cast : Vector3, current_node : Node) -> MUW_Tiles:

	var tile_processor = MUW_Tiles_Processor_Factory.new().create_3d(cast, current_node)
	return _build_tiles(tile_processor)
	

func _build_tiles(tile_processor) -> MUW_Tiles:
	var tiles = {}
	for vec2 in _tile_data:
		tiles[vec2] = tile_processor.create(vec2, _tile_data[vec2])
	return MUW_Tiles.new(tiles)