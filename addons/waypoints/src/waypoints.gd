
var _pathing : MUP_Pathing
var _transformer
var _waypoints = []
var _origin = Vector2(0, 0)
var _waypoint_data_factory : MUW_Waypoint_Data_Factory
var _structure

#TODO may get rid of this
export (GDScript) var waypoint_override

func _init(pathing : MUP_Pathing, transformer, structure, waypoint_data_factory : MUW_Waypoint_Data_Factory):
	_pathing = pathing
	_transformer = transformer
	_structure = structure
	_waypoint_data_factory = waypoint_data_factory


func create_waypoint(pos : Vector2) -> void:
	var world_start = _resolve_position_from_id(-1)
	var world_end = _transformer.transform(pos)
	var path_points = _pathing.get_path(world_start, world_end)
	var waypoint_data = _waypoint_data_factory.create(path_points, world_end)
	_waypoints.append(waypoint_data)
	_structure.create(waypoint_data)


func get_waypoint_id_from_pos(pos : Vector2):
	var world_pos = _transformer.transform(pos)
	for id in range(_waypoints.size()):
		var waypoint_world_position = _waypoints[id].get_world_position()
		if waypoint_world_position == world_pos:
			return id
	return null
	

func update_waypoints_from_pos(id : int, pos : Vector2) -> void:
	
	var previous_id = id - 1
	var next_id = id + 1
	var world_start = _resolve_position_from_id(previous_id, true)
	var world_end = _transformer.transform(pos)
	var path_points = _pathing.get_path(world_start, world_end)

	_waypoints[id].set_world_position(world_end)
	_waypoints[id].set_path(path_points)
	_structure.set(id, _waypoints[id])

	
	var position_next_waypoint = _resolve_position_from_id(next_id , true)
	
	if position_next_waypoint != null:
		world_start = _transformer.transform(pos)
		world_end = position_next_waypoint
		path_points = _pathing.get_path(world_start, world_end)
		_waypoints[next_id].set_path(path_points)
		_structure.set(next_id, _waypoints[next_id])


func remove_waypoint(id : int) -> void:
	var previous_id = id - 1
	var next_id = id + 1
	var start = _resolve_position_from_id(previous_id , true)
	var end = _resolve_position_from_id(next_id , true)
		
	if end != null:
		var path_points = _pathing.get_path(start, end)
		_waypoints[next_id].set_path(path_points)

	_structure.remove(id)
	_waypoints.remove(id)


func empty() -> bool:
	return _waypoints.empty()


func _resolve_position_from_id(id : int, absolute = false):
	
	if _waypoints.empty():
		return _origin
		
	if absolute:
		var ids = range(_waypoints.size())
		if ids.has(id):
			return _waypoints[id].get_world_position()
		elif id < ids.front():
			return _origin
		else:
			return null
	
	return _waypoints[id].get_world_position()