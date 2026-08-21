class_name MUW_Waypoints_Static

var _pathing : MUP_Pathing
var _transformer
var _origin = Vector2(0, 0)
var _structure
var _waypoints_collection : MUW_Waypoints_Data_Collection
var _layer


func _init(pathing : MUP_Pathing, transformer, structure, waypoints_collection : MUW_Waypoints_Data_Collection):

	_pathing = pathing
	_transformer = transformer
	_structure = structure
	_waypoints_collection = waypoints_collection


func set_layer(id : int):

	_waypoints_collection.set_layer(id)
	_layer = id


func create_waypoint(pos : Vector2) -> void:
	
	var world_start = _resolve_position_from_id(-1)
	var world_end = _transformer.transform(pos)
	var path_points = _pathing.get_path(world_start, world_end)

	_waypoints_collection.add_direction(path_points, world_end)
	_waypoints_collection.empty()
	var path_store = _waypoints_collection.get_store()	
	_structure.send(path_store, _layer)


func remove_waypoint(pos : Vector2) -> void:

	var world_pos = _transformer.transform(pos)
	var store = _waypoints_collection.get_store()
	store.remove(world_pos)
	_structure.send(store, _layer)
	

func _resolve_position_from_id(id : int, absolute = false):
	
	if _waypoints_collection.is_empty():
		return _origin
		
	if absolute:
		var ids = range(_waypoints_collection.get_size())
		if ids.has(id):
			return _waypoints_collection.get_data(id).get_world_position()
		elif id < ids.front():
			return _origin
		else:
			return null

	return _waypoints_collection.get_data(id).get_world_position()

