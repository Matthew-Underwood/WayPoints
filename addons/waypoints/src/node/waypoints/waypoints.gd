extends Node2D

var _waypoint_packed : PackedScene
var _pathing : Pathing
var _world : MU_World
var _waypoints = []
var _origin : Vector2 = Vector2(1,1)
export (GDScript) var waypoint_override

func _ready():
	_waypoint_packed = preload("res://addons/waypoints/scenes/waypoint.tscn")
	

func create_waypoint(pos : Vector2) -> void:
	var waypoint = _waypoint_packed.instance()
	
	if waypoint_override != null:
		waypoint.set_script(waypoint_override)
	
	var world_start = _resolve_position_from_id(-1)
	var world_end = _world.global_to_world(pos)

	var path = _pathing.getPath(world_start, world_end)	
	var world_vec2_path = []
	waypoint.position = _convert_vec2_to_global(world_end)
	for item in path:
		world_vec2_path.append(_convert_vec3_to_global(item) - waypoint.position)
	waypoint.set_path(world_vec2_path)
	_waypoints.append(waypoint)
	add_child(waypoint)


func get_all() -> Array:
	return _waypoints


func get_waypoint_id_from_pos(pos : Vector2):
	var world_pos = _world.global_to_world(pos)
	for id in range(_waypoints.size()):
		if _world.global_to_world(_waypoints[id].position) == world_pos:
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
		var path = _pathing.getPath(start, end)
		#TODO this is duplication and needs abstraction
		var world_vec2_path = []
		for item in path:
			world_vec2_path.append(_convert_vec3_to_global(item) - _waypoints[next_id].position)
		_waypoints[next_id].set_path(world_vec2_path)
	remove_child(_waypoints[id])
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
			return _world.global_to_world(_waypoints[id].position)
		elif id < ids.front():
			return _origin
		else:
			return null
	
	return _world.global_to_world(_waypoints[id].position)
	
	
func _convert_vec2_to_global(pos : Vector2):
	return _world.world_to_global(pos)


func _convert_vec3_to_global(pos : Vector3):
	var vec3_pos = MU_Ultilities_Vector.vector3_vector2(pos)
	return _world.world_to_global(vec3_pos)
