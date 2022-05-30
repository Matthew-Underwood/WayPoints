class_name MUP_World_Transformers_Screen_Tilemap

var _tilemap : TileMap

func _init(tilemap : TileMap):
    _tilemap = tilemap


func transform(pos : Vector2) -> Vector3:
    var map_pos = _tilemap.world_to_map(pos)
    return Vector3(map_pos.x, map_pos.y, 0)