class_name MUW_World_Factory

var _unwalkable_points : Array
var _tiles : MUW_Tiles
var _world_size := Vector2(10, 10)


func create_3d(cast_to : Vector3, parent_node : Node, camera : Camera, world : World) -> MUW_World_3d:

	var path_store_factory = MUW_Path_Directions_Store_Factory.new()
	var static_path_store = path_store_factory.create() 
	var connected_path_store = path_store_factory.create() 
	var waypoint_data_factory = MUW_Waypoint_Data_Factory.new()
	var waypoint_data_collection_factory = MUW_Waypoints_Data_Collection_Factory.new(waypoint_data_factory, path_store_factory)
	var points = MUW_Points.new()
	var tiles = MUW_Tiles_Factory.new(_tile_data_3d(), points).create_3d(cast_to, parent_node)
	var pathing = MUP_Pathing_Factory.new(tiles).create()
	var path_store_registry = MUW_Path_Directions_Store_Registry.new(static_path_store, connected_path_store)
	var waypoints_factory = MUW_Waypoints_Factory.new(pathing, points, waypoint_data_collection_factory, path_store_registry)
	var mesh_picker = MUW_Mesh_Picker.new(camera, world)
	var transformer = MUW_Transformers_Screen_Mesh.new(mesh_picker)


	var map_world = MUW_World.new(transformer, tiles)
	var waypoint_node_operations_factory = MUW_Node_Waypoints_Operations_Factory.new(waypoints_factory, map_world)
	var waypoint_operations_factory = MUW_Waypoints_Operations_Factory.new(waypoints_factory, map_world, path_store_registry)
	return MUW_World_3d.new(waypoint_operations_factory, waypoint_node_operations_factory)

#func create_2d(tilemap : TileMap) -> MUW_World_2d:


#TODO this is temp, implement loading from file or something
func _tile_data_3d() -> Dictionary:
	
	var tile_data = {}
	var inpassable_tile_points = [Vector2(4, 3), Vector2(4, 4), Vector2(4, 5), Vector2(4, 6)]
	var slope_vectors = [
		Vector2(3, 2), Vector2(4, 2), Vector2(5, 2), Vector2(6, 2),
		Vector2(2, 3), Vector2(2, 4), Vector2(2, 5), Vector2(2, 6), 
		Vector2(3, 7), Vector2(4, 7), Vector2(5, 7), Vector2(6, 7), 
		Vector2(7, 3), Vector2(7, 4), Vector2(7, 5), Vector2(7, 6)
	]

	for x in range(_world_size.x):
		for y in range(_world_size.y):
			tile_data[Vector2(x, y)] = {"type" : MUW_Tile_Types.FLAT}

	tile_data[Vector2(2, 2)] = {"type" : MUW_Tile_Types.CORNER}
	tile_data[Vector2(7, 7)] = {"type" : MUW_Tile_Types.CORNER}
	tile_data[Vector2(7, 2)] = {"type" : MUW_Tile_Types.CORNER}
	tile_data[Vector2(2, 7)] = {"type" : MUW_Tile_Types.CORNER}

	for slope_vector in slope_vectors:
		tile_data[slope_vector] = {"type" : MUW_Tile_Types.SLOPE}

	# tile_data[Vector2(4, 3)] = {"type" : MUW_Tile_Types.INPASSABLE}
	# tile_data[Vector2(4, 4)] = {"type" : MUW_Tile_Types.INPASSABLE}
	# tile_data[Vector2(4, 5)] = {"type" : MUW_Tile_Types.INPASSABLE}
	# tile_data[Vector2(4, 6)] = {"type" : MUW_Tile_Types.INPASSABLE}

	return tile_data


func _tile_data_2d(tilemap : TileMap) -> Dictionary:

	var tile_data = {}
	var inpassable_tile_points = tilemap.get_used_cells_by_id(0)
	
	for x in range(_world_size.x):
		for y in range(_world_size.y):
			tile_data[Vector2(x, y)] = {"type" : MUW_Tile_Types.FLAT}
	
	for inpassable_tile_point in inpassable_tile_points:
		tile_data[inpassable_tile_point] = {"type" : MUW_Tile_Types.INPASSABLE}

	return tile_data
