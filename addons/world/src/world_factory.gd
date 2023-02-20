class_name MUW_World_Factory


var _dimension_processor
var _size : Vector2
var _unwalkable_points : Array

func _init(
    dimension_processor,
    size : Vector2,
    unwalkable_points = []
):
    _dimension_processor = dimension_processor
    _size = size
    _unwalkable_points = unwalkable_points

func create_spatial(camera : Camera, world : World) -> MUW_World:
    var mesh_picking = MUW_Mesh_Picker.new(camera, world)
    var screen_mesh_transformer = MUW_Transformers_Screen_Mesh.new(mesh_picking)
    return MUW_World.new(_dimension_processor, _size, _unwalkable_points, screen_mesh_transformer)


func create_2d(tilemap : TileMap) -> MUW_World:
    var screen_tilemap_transformer = MUW_Transformers_Screen_Tilemap.new(tilemap)
    return MUW_World.new(_dimension_processor, _size, _unwalkable_points, screen_tilemap_transformer)