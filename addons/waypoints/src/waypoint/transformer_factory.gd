class_name MUW_Waypoint_Transformer_Factory

func create_mesh_transformer() -> MUW_Waypoint_Transformers_Mesh:
	return  MUW_Waypoint_Transformers_Mesh.new()

func create_tilemap_transformer(tilemap : TileMap) -> MUW_Waypoint_Transformers_Tilemap:
	return MUW_Waypoint_Transformers_Tilemap.new(tilemap)
