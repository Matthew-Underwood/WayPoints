class_name MUW_Transformer_Factory

var _tilemap : TileMap

func _init(tilemap : TileMap):
    _tilemap = tilemap


func create_mesh_transformer() -> MUW_Transform_Mesh_Transformer:
    return  MUW_Transform_Mesh_Transformer.new()

func create_tilemap_transformer() -> MUW_Transform_Tilemap_Transformer:
    return MUW_Transform_Tilemap_Transformer.new(_tilemap)