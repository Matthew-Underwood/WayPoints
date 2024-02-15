class_name MUW_WayPoints

var _waypoint_factory : MUW_Waypoint_Factory
var _pathing : MUP_Pathing
var _transformer
var _waypoints = []
var _origin = Vector2(0, 0)


func _init(waypoint_factory : MUW_Waypoint_Factory, pathing : MUP_Pathing, transformer):
	_waypoint_factory = waypoint_factory
	_pathing = pathing
	_transformer = transformer


func create_waypoint(pos : Vector2) -> MUW_WayPoint: 

	var world_start = _resolve_position_from_id(-1)
	var world_end = _transformer.transform(pos)
	var path_points = _pathing.get_path(world_start, world_end)
	var id = _waypoints.size() + 1
	return _waypoint_factory.create(id, path_points, world_end)


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
	var path_points = _pathing.get_path(world_start, world_end)

	_waypoints[id].set_world_position(world_end)
	_waypoints[id].set_points(path_points)
	
	var position_next_waypoint = _resolve_position_from_id(next_id , true)
	
	if position_next_waypoint != null:
		world_start = _transformer.transform(pos)
		world_end = position_next_waypoint
		path_points = _pathing.get_path(world_start, world_end)
		_waypoints[next_id].set_points(path_points)


func remove_waypoint(id : int) -> void:

	var previous_id = id - 1
	var next_id = id + 1
	var start = _resolve_position_from_id(previous_id , true)
	var end = _resolve_position_from_id(next_id , true)
		
	if end != null:
		var points_path = _pathing.get_path(start, end)
		_waypoints[next_id].set_points(points_path)
	_waypoints.remove(id)

	for update_id in range(id, _waypoints.size()):
		_waypoints[update_id].set_id(update_id + 1)


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