class_name MUW_Waypoint_Data

var _path : PoolVector3Array
var _path_vec2 : Array
var _world_position : Vector2


func _init(path : PoolVector3Array, world_position : Vector2):

	set_path(path)
	_world_position = world_position


func get_path() -> PoolVector3Array:

	return _path


func get_path_as_vec2() -> Array:

	return _path_vec2
	

func get_world_position() -> Vector2:

	return _world_position


func set_path(path : PoolVector3Array):

	_path = path
	_set_path_vec2(path)


func _set_path_vec2(path : PoolVector3Array):

	_path_vec2 = []
	for v in range(path.size()):
		var vec3_pos = path[v]
		var vec2_pos = Vector2(vec3_pos.x, vec3_pos.z)
		if vec2_pos == vec2_pos.floor() + Vector2(0.5, 0.5):
			_path_vec2.append(vec2_pos.floor())


func set_world_position(pos : Vector2):

	_world_position = pos

