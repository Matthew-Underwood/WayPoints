class_name MUW_Waypoints_Static

var _pathing : MUP_Pathing
var _transformer
var _waypoints = []
var _origin = Vector2(0, 0)
var _structure
var _waypoints_collection : MUW_Waypoints_Data_Collection


func _init(pathing : MUP_Pathing, transformer, structure, waypoints_collection : MUW_Waypoints_Data_Collection):

	_pathing = pathing
	_transformer = transformer
	_structure = structure
	_waypoints_collection = waypoints_collection


func create_waypoint(pos : Vector2) -> void:
	
	var world_start = _resolve_position_from_id(-1)
	var world_end = _transformer.transform(pos)
	var path_points = _pathing.get_path(world_start, world_end)

    _waypoints_collection.add(path_points, world_end)
    _waypoints_collection.empty()
	_structure.create(waypoint_data)


func remove_waypoint(pos : Vector2) -> void:

    var store = _waypoints_collection.get_store()

	store.remove(id)
	_structure.remove(id)

