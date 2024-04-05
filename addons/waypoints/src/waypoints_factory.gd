class_name MUW_Waypoints_Factory

var _pathing : MUP_Pathing
var _waypoint_data_factory : MUW_Waypoint_Data_Factory
var _tiles_factory

func _init(pathing : MUP_Pathing, waypoint_data_factory : MUW_Waypoint_Data_Factory, tiles_factory : MUW_Tiles_Factory):
	_pathing = pathing
	_waypoint_data_factory = waypoint_data_factory
	_tiles_factory = tiles_factory


func create_2d_nodes(parent_node : Node, tilemap : TileMap) -> MUW_Waypoints:
	var transformer = MUW_Transformers_Screen_Tilemap.new(tilemap)
	var waypoint_packed = preload("res://addons/waypoints/scenes/2d/waypoint.tscn")
	var waypoints_packed = preload("res://addons/waypoints/scenes/2d/waypoints.tscn")
	var waypoint_factory = MUW_Waypoint_Factory.new(parent_node, waypoints_packed, waypoint_packed)
	var structure = MUW_Node_Structure.new(waypoint_factory)
	return MUW_Waypoints.new(_pathing, _waypoint_data_factory, transformer, structure)


func create_3d_nodes(parent_node : Node, camera : Camera, world : World) -> MUW_Waypoints:
	var points = MUW_Points.new()
	var mesh_picking = MUW_Mesh_Picker.new(camera, world)
	var transformer = MUW_Transformers_Screen_Mesh.new(mesh_picking)

	var waypoint_packed = preload("res://addons/waypoints/scenes/3d/waypoint.tscn")
	var waypoints_packed = preload("res://addons/waypoints/scenes/3d/waypoints.tscn")
	var waypoint_factory = MUW_Waypoint_Factory.new(parent_node, waypoints_packed, waypoint_packed, points)
	var structure = MUW_Node_Structure.new(waypoint_factory)
	return MUW_Waypoints.new(_pathing, _waypoint_data_factory, transformer, structure)


func create_3d_paths(camera : Camera, world : World) -> MUW_Waypoints:
	var points = MUW_Points.new()
	var mesh_picking = MUW_Mesh_Picker.new(camera, world)
	var transformer = MUW_Transformers_Screen_Mesh.new(mesh_picking)

	var texture_map = MUT_Texture_Map_Factory.new().create(_world_size)
	mask_shader.set_shader_param("map_size", _world_size)
	mask_shader.set_shader_param("map", texture_map.get_map())
	var structure = MUW_Path_Structure.new(texture_map, mask_shader)

	return MUW_Waypoints.new(_pathing, _waypoint_data_factory, transformer, structure)