class_name MUW_Waypoints_Factory

var _pathing : MUP_Pathing
var _points : MUW_Points
var _waypoint_collection_factory : MUW_Waypoints_Collection_Factory

func _init(pathing : MUP_Pathing, points : MUW_Points, waypoint_collection_factory : MUW_Waypoints_Collection_Factory):
	_pathing = pathing
	_points = points
    _waypoint_collection_factory = waypoint_collection_factory

func create_2d_nodes(parent_node : Node, tilemap : TileMap) -> MUW_Waypoints:
	var transformer = MUW_Transformers_Screen_Tilemap.new(tilemap)
	var waypoint_packed = preload("res://addons/waypoints/assets/scenes/2d/waypoint.tscn")
	var waypoints_packed = preload("res://addons/waypoints/assets/scenes/2d/waypoints.tscn")
	var waypoint_factory = MUW_Waypoint_Factory.new(parent_node, waypoints_packed, waypoint_packed)
	var structure = MUW_Node_Structure.new(waypoint_factory)
    var waypoint_collection = _waypoint_collection_factory.create()
	return MUW_Waypoints.new(_pathing, transformer, structure, waypoint_collection)


func create_3d_nodes(parent_node : Node, camera : Camera, world : World) -> MUW_Waypoints:
	var mesh_picking = MUW_Mesh_Picker.new(camera, world)
	var transformer = MUW_Transformers_Screen_Mesh.new(mesh_picking)

	var waypoint_packed = preload("res://addons/waypoints/assets/scenes/3d/waypoint.tscn")
	var waypoints_packed = preload("res://addons/waypoints/assets/scenes/3d/waypoints.tscn")
	var waypoint_factory = MUW_Waypoint_Factory.new(parent_node, waypoints_packed, waypoint_packed, _points)
	var structure = MUW_Node_Structure.new(waypoint_factory)
    var waypoint_collection = _waypoint_collection_factory.create()
	return MUW_Waypoints.new(_pathing, transformer, structure, waypoint_collection)


func create_3d_paths(parent_node : Node, size : Vector2, camera : Camera, world : World) -> MUW_Waypoints:
	var points = MUW_Points.new()
	var mesh_picking = MUW_Mesh_Picker.new(camera, world)
	var transformer = MUW_Transformers_Screen_Mesh.new(mesh_picking)

	var texture_map = MUT_Texture_Map_Factory.new().create(size)
	var roads = parent_node.find_node("RoadsMask")
	var mask_shader = roads.get_active_material(0)
	mask_shader.set_shader_param("map_size", size)
	mask_shader.set_shader_param("bezier_path_map", texture_map.get_map())
	var structure = MUW_Path_Structure.new(texture_map, mask_shader)
    var waypoint_collection = _waypoint_collection_factory.create()
	return MUW_Waypoints.new(_pathing, transformer, structure, waypoint_collection)
