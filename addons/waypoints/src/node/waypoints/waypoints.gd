extends Node2D

var _waypoint_packed : PackedScene
var _pathing : Pathing
var _world #TODO cant be typed. Is there a way around this?
var _waypoints = []
var _origin : Vector2 = Vector2(1,1)
export (GDScript) var waypoint_override

func _ready():
	_waypoint_packed = preload("res://addons/waypoints/scenes/waypoint.tscn")
	

func create_waypoint(pos : Vector2) -> void:
	var waypoint = _waypoint_packed.instance()
	
	if waypoint_override != null:
		waypoint.set_script(waypoint_override)
	
	waypoint.set_world(_world.get_world())
	var world_start = _resolve_position_from_id(-1)
	var world_end = _world.global_to_world(pos)
	waypoint.set_path(_pathing.getPath(world_start, world_end))
	_waypoints.append(waypoint)
	add_child(waypoint)


func get_all() -> Array:
	return _waypoints


func get_waypoint_id_from_pos(pos : Vector2):
	var world_pos = _world.global_to_world(pos)
	for id in range(_waypoints.size()):
		if _waypoints[id].get_position() == world_pos:
			return id
	return null
	

func update_waypoints_from_pos(id : int, pos : Vector2) -> void:
	
	var previous_id = id - 1
	var next_id = id + 1
	var world_start = _resolve_position_from_id(previous_id, true)
	var world_end = _world.global_to_world(pos)
	_waypoints[id].set_path(_pathing.getPath(world_start, world_end))
	
	var position_next_waypoint = _resolve_position_from_id(next_id , true)
	
	if position_next_waypoint != null:
		world_start = _world.global_to_world(pos)
		world_end = position_next_waypoint
		_waypoints[next_id].set_path(_pathing.getPath(world_start, world_end))


func remove_waypoint(id : int) -> void:
	var next_id = id + 1
	var previous_id = id - 1
	var start = _resolve_position_from_id(previous_id , true)
	var end = _resolve_position_from_id(next_id , true)
		
	if end != null:
		_waypoints[next_id].set_path(_pathing.getPath(start, end))
		
	_waypoints[id].hide()
	_waypoints.remove(id)


func empty() -> bool:
	return _waypoints.empty()


func set_origin(pos : Vector2) -> void:
	_origin = _world.global_to_world(pos)


func set_pathing(pathing : Pathing) -> void:
	_pathing = pathing


func set_world(world) -> void:
	_world = world


func _resolve_position_from_id(id : int, absolute = false):
	
	if _waypoints.empty():
		return _origin
		
	if absolute:
		var ids = range(_waypoints.size())
		if ids.has(id):
			return _waypoints[id].get_position()
		elif id < ids.front():
			return _origin
		else:
			return null
	
	return _waypoints[id].get_position()
	
	

