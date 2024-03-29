extends Node

var _waypoint_factory : MUW_Waypoint_Factory
var _pathing : MUP_Pathing
var _transformer
var _waypoints = []
var _origin = Vector2(0, 0)

export (GDScript) var waypoint_override

func set_waypoint_factory(waypoint_factory : MUW_Waypoint_Factory) -> void:
	_waypoint_factory = waypoint_factory


func create_waypoint(pos : Vector2) -> void:
	var waypoint = _waypoint_factory.create(waypoint_override)

	var world_start = _resolve_position_from_id(-1)
	var world_end = _transformer.transform(pos)
	waypoint.set_world_position(world_end)
	_process_path(waypoint, world_start, world_end)
	
	waypoint.set_id(str(_waypoints.size() + 1))
	_waypoints.append(waypoint)
	add_child(waypoint)


func get_all() -> Array:
	return _waypoints


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
	_waypoints[id].set_world_position(world_end)
	_process_path(_waypoints[id], world_start, world_end)

	
	var position_next_waypoint = _resolve_position_from_id(next_id , true)
	
	if position_next_waypoint != null:
		world_start = _transformer.transform(pos)
		world_end = position_next_waypoint
		_process_path(_waypoints[next_id], world_start, world_end)


func remove_waypoint(id : int) -> void:
	var previous_id = id - 1
	var next_id = id + 1
	var start = _resolve_position_from_id(previous_id , true)
	var end = _resolve_position_from_id(next_id , true)
		
	if end != null:
		_process_path(_waypoints[next_id], start, end)
	_waypoints[id].queue_free()
	_waypoints.remove(id)

	for update_id in range(id, _waypoints.size()):
		_waypoints[update_id].set_id(str(update_id + 1))


func empty() -> bool:
	return _waypoints.empty()


func set_origin(origin : Vector2):
	_origin = origin


func set_pathing(pathing : MUP_Pathing) -> void:
	_pathing = pathing


func set_transformer(transformer) -> void:
	_transformer = transformer


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
	
	
func _process_path(waypoint, start : Vector2, end : Vector2) -> void:

	var path_points = _pathing.get_path(start, end)
	waypoint.set_path(path_points)
