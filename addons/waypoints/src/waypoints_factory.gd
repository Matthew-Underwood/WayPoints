class_name MUW_Waypoints_Factory

var _pathing : MUP_Pathing
var _points : MUW_Points
var _waypoint_collection_factory : MUW_Waypoints_Data_Collection_Factory
var _path_store_registry : MUW_Path_Directions_Store_Registry

func _init(
	pathing : MUP_Pathing,
	points : MUW_Points,
	waypoint_collection_factory : MUW_Waypoints_Data_Collection_Factory,
	path_store_registry : MUW_Path_Directions_Store_Registry
):

	_pathing = pathing
	_points = points
	_waypoint_collection_factory = waypoint_collection_factory
	_path_store_registry = path_store_registry

#TODO Will need to rework this now that we use static and connected
#func create_2d_nodes(parent_node : Node, tilemap : TileMap) -> MUW_Waypoints:
#
#	var transformer = MUW_Transformers_Screen_Tilemap.new(tilemap)
#	var waypoint_packed = preload("res://addons/waypoints/assets/scenes/2d/waypoint.tscn")
#	var waypoints_packed = preload("res://addons/waypoints/assets/scenes/2d/waypoints.tscn")
#	var waypoint_factory = MUW_Waypoint_Factory.new(parent_node, waypoints_packed, waypoint_packed)
#	var structure = MUW_Node_Structure.new(waypoint_factory)
#	var waypoint_collection = _waypoint_collection_factory.create()
#
#	return MUW_Waypoints.new(_pathing, transformer, structure, waypoint_collection)


#TODO Will need to rework this now that we use static and connected
#func create_3d_nodes(parent_node : Node, camera : Camera, world : World) -> MUW_Waypoints:
#
#	var mesh_picking = MUW_Mesh_Picker.new(camera, world)
#	var transformer = MUW_Transformers_Screen_Mesh.new(mesh_picking)
#	var waypoint_packed = preload("res://addons/waypoints/assets/scenes/3d/waypoint.tscn")
#	var waypoints_packed = preload("res://addons/waypoints/assets/scenes/3d/waypoints.tscn")
#	var waypoint_factory = MUW_Waypoint_Factory.new(parent_node, waypoints_packed, waypoint_packed, _points)
#	var structure = MUW_Node_Structure.new(waypoint_factory)
#	var waypoint_collection = _waypoint_collection_factory.create()
#
#	return MUW_Waypoints.new(_pathing, transformer, structure, waypoint_collection)


func create_3d(parent_node : Node, size : Vector2, camera : Camera, world : World):

	var points = MUW_Points.new()
	var mesh_picking = MUW_Mesh_Picker.new(camera, world)
	var transformer = MUW_Transformers_Screen_Mesh.new(mesh_picking)
	var roads = parent_node.find_node("RoadsMask")
	var path_material_factory = MUW_Path_Material_Factory.new()

	var path_material = path_material_factory.create(
		[
			{"id" : 0, "colour" : Vector3(1.0, 1.0, 1.0), "size" : Vector2(10, 10)},
			{"id" : 1, "colour" : Vector3(0.0, 1.0, 0.0), "size" : Vector2(10, 10)}
		]
	)
	
	roads.mesh.surface_set_material(0, path_material.get_material())

	var structure = MUW_Path_Structure.new(path_material)
	var static_waypoint_collection = _waypoint_collection_factory.create()
	var static_path_store = static_waypoint_collection.get_store()
	var connected_waypoint_collection = _waypoint_collection_factory.create()
	var connected_path_store = connected_waypoint_collection.get_store()
	_path_store_registry.set_static_path_store(static_path_store)
	_path_store_registry.set_connected_path_store(connected_path_store)
	var path_store = MUW_Path_Directions_Store_Factory.new().create()
	
	var connected_waypoints = MUW_Waypoints_Connected.new(_pathing, transformer, structure, connected_waypoint_collection, path_store)

	return connected_waypoints

