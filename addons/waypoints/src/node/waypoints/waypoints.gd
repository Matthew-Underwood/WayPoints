extends Node2D

var _waypoint_packed : PackedScene
var _pathing : MUP_Pathing
var _world : MUP_World
var _waypoints = []
var _waypoint_transform
var _origin = Vector3(1, 1, 0)
export (GDScript) var waypoint_override


func set_waypoint(waypoint : PackedScene) -> void:
	_waypoint_packed = waypoint


func set_waypoint_transform(waypoint_transform) -> void:
	_waypoint_transform = waypoint_transform 
	

func create_waypoint(pos : Vector2) -> void:
	var waypoint = _waypoint_packed.instance()
	
	if waypoint_override != null:
		waypoint.set_script(waypoint_override)
	
	var world_start = _resolve_position_from_id(-1)
	var world_end = _world.screen_to_world(pos)
	# need to translate to 2d or 3d position
	waypoint.position = _waypoint_transform.transform(world_end)

	_process_path(waypoint, world_start, world_end)
	_waypoints.append(waypoint)
	add_child(waypoint)


func get_all() -> Array:
	return _waypoints


func get_waypoint_id_from_pos(pos : Vector2):
	var world_pos = _world.screen_to_world(pos)
	for id in range(_waypoints.size()):
		if _world.screen_to_world(_waypoints[id].position) == world_pos:
			return id
	return null
	

func update_waypoints_from_pos(id : int, pos : Vector2) -> void:
	
	var previous_id = id - 1
	var next_id = id + 1
	var world_start = _resolve_position_from_id(previous_id, true)
	var world_end = _world.screen_to_world(pos)
	_waypoints[id].position = _waypoint_transform.transform(world_end)
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


func set_origin(pos : Vector2) -> void:
	_origin = _world.screen_to_world(pos)


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
			return _world.screen_to_world(_waypoints[id].position)
		elif id < ids.front():
			return _origin
		else:
			return null
	
	return _world.screen_to_world(_waypoints[id].position)
	
	
func _process_path(waypoint : WayPoint, start : Vector3, end : Vector3) -> void:
	var path = _pathing.getPath(start, end)
	var world_vec2_path = []
	for item in path:
		world_vec2_path.append(_waypoint_transform.transform(item) - waypoint.position)
	waypoint.set_path(world_vec2_path)