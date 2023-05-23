class_name MUW_World_Factory

var _unwalkable_points : Array
var _tiles : MUW_Tiles


func create_3d(cast_to : Vector3, parent_node : Node, camera : Camera, world : World) -> MUW_World:
	var tile_data = _tile_data_3d()
	var points = MUW_Points.new()
	var mesh_picking = MUW_Mesh_Picker.new(camera, world)
	var transformer = MUW_Transformers_Screen_Mesh.new(mesh_picking)

	var tiles = MUW_Tiles_Factory.new(tile_data).create_3d(cast_to, parent_node, points)
	var waypoint_packed = preload("res://addons/waypoints/scenes/3d/waypoint.tscn")
	var waypoints_packed = preload("res://addons/waypoints/scenes/3d/waypoints.tscn")
	var pathing = MUP_Pathing_Factory.new(tiles).create()
	var waypoints = MUW_Waypoints_Factory.new(pathing).create_3d(waypoints_packed, waypoint_packed, transformer, points)
	parent_node.add_child(waypoints)
	return MUW_World.new(transformer, tiles, waypoints)


func create_2d(parent_node : Node, tilemap : TileMap) -> MUW_World:
	var tile_data = _tile_data_2d(tilemap)
	var transformer = MUW_Transformers_Screen_Tilemap.new(tilemap)
	var tiles = MUW_Tiles_Factory.new(tile_data).create_2d(tilemap)
	var waypoint_packed = preload("res://addons/waypoints/scenes/2d/waypoint.tscn")
	var waypoints_packed = preload("res://addons/waypoints/scenes/2d/waypoints.tscn")
	var pathing = MUP_Pathing_Factory.new(tiles).create()
	var waypoints = MUW_Waypoints_Factory.new(pathing).create_2d(waypoints_packed, waypoint_packed, transformer)
	parent_node.add_child(waypoints)
	return MUW_World.new(transformer, tiles, waypoints)


#TODO this is temp, implement loading from file or something
func _tile_data_3d() -> Dictionary:
	
	var tile_data = {}
	var inpassable_tile_points = [Vector2(4, 3), Vector2(4, 4), Vector2(4, 5), Vector2(4, 6)]
	var world_size = Vector2(10, 10)
	var slope_vectors = [
		Vector2(3, 2), Vector2(4, 2), Vector2(5, 2), Vector2(6, 2),
		Vector2(2, 3), Vector2(2, 4), Vector2(2, 5), Vector2(2, 6), 
		Vector2(3, 7), Vector2(4, 7), Vector2(5, 7), Vector2(6, 7), 
		Vector2(7, 3), Vector2(7, 4), Vector2(7, 5), Vector2(7, 6)
	]
	for x in range(world_size.x):
		for y in range(world_size.y):
			tile_data[Vector2(x, y)] = {"type" : MUW_Tile_Types.FLAT}

	tile_data[Vector2(2, 2)] = {"type" : MUW_Tile_Types.CORNER}
	tile_data[Vector2(7, 7)] = {"type" : MUW_Tile_Types.CORNER}
	tile_data[Vector2(7, 2)] = {"type" : MUW_Tile_Types.CORNER}
	tile_data[Vector2(2, 7)] = {"type" : MUW_Tile_Types.CORNER}

	for slope_vector in slope_vectors:
		tile_data[slope_vector] = {"type" : MUW_Tile_Types.SLOPE}

	for inpassable_tile_point in inpassable_tile_points:
		tile_data[inpassable_tile_point] = {"type" : MUW_Tile_Types.INPASSABLE}

	return tile_data


func _tile_data_2d(tilemap : TileMap) -> Dictionary:

	var tile_data = {}
	var inpassable_tile_points = tilemap.get_used_cells_by_id(0)
	var world_size = Vector2(10, 10)
	
	for x in range(world_size.x):
		for y in range(world_size.y):
			tile_data[Vector2(x, y)] = {"type" : MUW_Tile_Types.FLAT}
	
	for inpassable_tile_point in inpassable_tile_points:
		tile_data[inpassable_tile_point] = {"type" : MUW_Tile_Types.INPASSABLE}

	return tile_data
