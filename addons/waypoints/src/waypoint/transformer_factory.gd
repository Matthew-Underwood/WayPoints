class_name MUW_Waypoint_Transformer_Factory

func create_mesh_transformer() -> MUW_Waypoint_Transformers_Mesh_Transformer:
    return  MUW_Waypoint_Transformers_Mesh_Transformer.new()

func create_tilemap_transformer(tilemap : TileMap) -> MUW_Waypoint_Transformers_Tilemap_Transformer:
    return MUW_Waypoint_Transformers_Tilemap_Transformer.new(tilemap)