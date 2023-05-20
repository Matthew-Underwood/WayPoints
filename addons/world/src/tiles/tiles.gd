class_name MUW_Tiles

var _tiles : Dictionary

func _init(tiles : Dictionary):
	_tiles = tiles


func has_tile(point : Vector2) -> bool:
	return _tiles.has(point.floor())


func is_walkable(point : Vector2) -> bool:
	return _tiles[point.floor()]["type"] != MUW_Tile_Types.INPASSABLE


func get_all() -> Dictionary:
	return _tiles
