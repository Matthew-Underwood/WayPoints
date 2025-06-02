class_name MUW_Waypoints_Connected

var _pathing : MUP_Pathing
var _transformer
var _waypoints = []
var _origin = Vector2(0, 0)
var _structure
var _waypoints_collection : MUW_Waypoints_Data_Collection


func _init(pathing : MUP_Pathing, transformer, structure, waypoints_collection):

	_pathing = pathing
	_transformer = transformer
	_structure = structure
	_waypoints_collection = waypoints_collection


func create_waypoint(pos : Vector2) -> void:
	
	var world_start = _resolve_position_from_id(-1)
	var world_end = _transformer.transform(pos)
	var path_points = _pathing.get_path(world_start, world_end)

	_waypoints_collection.add_direction(path_points, world_end)
	var store = _waypoints_collection.get_store()
	_structure.send(store)


func get_waypoint_id_from_pos(pos : Vector2):

	var world_pos = _transformer.transform(pos)
	for id in range(_waypoints_collection.get_size()):
		var waypoint_world_position = _waypoints_collection.get_data(id).get_world_position()
		if waypoint_world_position == world_pos:
			return id
	return null
	

func set_waypoints_collection(waypoints_collection : MUW_Waypoints_Data_Collection):

	_waypoints_collection = waypoints_collection


func get_waypoints_collection() -> MUW_Waypoints_Data_Collection:

	return _waypoints_collection 


func update_waypoints_from_pos(id : int, pos : Vector2) -> void:
	
	var previous_id = id - 1
	var next_id = id + 1
	var world_start = _resolve_position_from_id(previous_id, true)
	var world_end = _transformer.transform(pos)
	var path_points = _pathing.get_path(world_start, world_end)

	_waypoints_collection.update(id, path_points, world_end)
	var store = _waypoints_collection.get_store()
	_structure.send(store)
		
	var position_next_waypoint = _resolve_position_from_id(next_id, true)
	
	if position_next_waypoint != null:
		world_start = _transformer.transform(pos)
		world_end = position_next_waypoint
		path_points = _pathing.get_path(world_start, world_end)
		_waypoints_collection.update(next_id, path_points, world_end)
		store = _waypoints_collection.get_store()
		_structure.send(store)


func remove_waypoint(id : int) -> void:

	var previous_id = id - 1
	var next_id = id + 1
	var start = _resolve_position_from_id(previous_id, true)
	var end = _resolve_position_from_id(next_id, true)
		
	if end != null:
		var path_points = _pathing.get_path(start, end)
		_waypoints_collection.update(next_id, path_points, end)

	_waypoints_collection.remove(id)
	var store = _waypoints_collection.get_store()
	_structure.send(store)	


func is_empty() -> bool:

	return _waypoints_collection.is_empty()


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
