extends Spatial

class_name MUW_Waypoint_Spatial

var _path = [] 
var _world_position : Vector3
var _transformer 

func set_transformer(transformer):
	_transformer = transformer


func get_world_position() -> Vector3:
	return _world_position


func set_world_position(pos : Vector3):
	pos = _transformer.transform(pos)
	transform.origin = pos
	_world_position = pos.floor()


func set_path(path : Array) -> void:
	_path = []
	for item in path:
		_path.append(_transformer.transform(item) - transform.origin)
