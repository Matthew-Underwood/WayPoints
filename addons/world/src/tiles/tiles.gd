class_name MUW_Tiles

var _tiles : Dictionary

func _init(tiles : Dictionary):
	_tiles = tiles


func get_all() -> Dictionary:
	return _tiles