extends Spatial

class_name MUW_Waypoint_Spatial

var _world_position : Vector3
var _transformer 
var _line_factory : MUW_Factory_Line

func set_transformer(transformer):
	_transformer = transformer


func set_line_factory(line_factory : MUW_Factory_Line):
	_line_factory = line_factory


func get_world_position() -> Vector3:
	return _world_position


func set_world_position(pos : Vector3):
	pos = _transformer.transform(pos)
	transform.origin = pos
	_world_position = pos.floor()


func set_path(path : Array) -> void:

	if !path.empty():
		for point_id in range(1, len(path)):
			var previous_point = path[point_id - 1]
			var point = path[point_id]
			previous_point = _transformer.transform(previous_point)
			point = _transformer.transform(point)
			var line = _line_factory.create(previous_point, point, transform.origin)
			add_child(line)