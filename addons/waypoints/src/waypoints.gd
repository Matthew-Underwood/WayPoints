extends Node

var _waypoint_factory
var _pathing : MUP_Pathing
var _world : MUP_World
var _waypoints = []
var _origin = Vector3(1, 1, 0)
export (GDScript) var waypoint_override


func set_waypoint_factory(waypoint_factory) -> void:
	_waypoint_factory = waypoint_factory


func create_waypoint(pos : Vector2) -> void:
	var waypoint = _waypoint_factory.create(waypoint_override)

	var world_start = _resolve_position_from_id(-1)
	var world_end = _world.screen_to_world(pos)
	waypoint.set_world_position(world_end)

	_process_path(waypoint, world_start, world_end)
	_waypoints.append(waypoint)
	add_child(waypoint)


func get_all() -> Array:
	return _waypoints


func get_waypoint_id_from_pos(pos : Vector2):
	var world_pos = _world.screen_to_world(pos)
	for id in range(_waypoints.size()):
		var waypoint_world_position = _waypoints[id].get_world_position()
		if waypoint_world_position == world_pos:
			return id
	return null
	

func update_waypoints_from_pos(id : int, pos : Vector2) -> void:
	
	var previous_id = id - 1
	var next_id = id + 1
	var world_start = _resolve_position_from_id(previous_id, true)
	var world_end = _world.screen_to_world(pos)
	_waypoints[id].set_world_position(world_end)
	_process_path(_waypoints[id], world_start, world_end)

	
	var position_next_waypoint = _resolve_position_from_id(next_id , true)
	
	if position_next_waypoint != null:
		world_start = _world.screen_to_world(pos)
		world_end = position_next_waypoint
		_process_path(_waypoints[next_id], world_start, world_end)


func remove_waypoint(id : int) -> void:
	var previous_id = id - 1
	var next_id = id + 1
	var start = _resolve_position_from_id(previous_id , true)
	var end = _resolve_position_from_id(next_id , true)
		
	if end != null:
		_process_path(_waypoints[next_id], start, end)
	remove_child(_waypoints[id])
	_waypoints.remove(id)


func empty() -> bool:
	return _waypoints.empty()


func get_origin() -> Vector3:
	return _origin


func set_pathing(pathing : MUP_Pathing) -> void:
	_pathing = pathing


func set_world(world : MUP_World) -> void:
	_world = world


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
	
	
func _process_path(waypoint, start : Vector3, end : Vector3) -> void:
	var path = _pathing.get_path(start, end)
	waypoint.set_path(path)
