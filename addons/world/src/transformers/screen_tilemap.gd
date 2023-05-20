class_name MUW_Transformers_Screen_Tilemap

var _tilemap : TileMap

func _init(tilemap : TileMap):
	_tilemap = tilemap


func transform(pos : Vector2) -> Vector2:
	return _tilemap.world_to_map(pos)
