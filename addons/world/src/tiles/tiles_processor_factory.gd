class_name MUW_Tiles_Processor_Factory

func create_2d(tilemap : TileMap) -> MUW_Tiles_Processor_2d:
	return MUW_Tiles_Processor_2d.new(tilemap)


func create_3d(cast_to : Vector3, parent_node : Node, points : MUW_Points) -> MUW_Tiles_Processor_3d:
	
	var rc = RayCast.new()
	rc.enabled = true
	rc.cast_to = cast_to
	parent_node.add_child(rc)
	var tile_processor = MUW_Tiles_Processor_3d.new(rc, points)
	rc.queue_free()
	return tile_processor
