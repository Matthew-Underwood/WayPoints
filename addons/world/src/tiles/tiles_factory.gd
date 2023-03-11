class_name MUW_Tiles_Factory

var _tile_processor


func _init(tile_processor):
	_tile_processor = tile_processor

func create(world_size : Vector2) -> MUW_Tiles:
	var tiles = {}
	for x in range(world_size.x):
		for y in range(world_size.y):
			var world_pos = Vector2(x, y)
			tiles[world_pos] = _tile_processor.create(world_pos)
	return MUW_Tiles.new(tiles)
