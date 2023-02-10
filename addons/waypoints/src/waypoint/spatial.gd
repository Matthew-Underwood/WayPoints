extends Spatial

class_name MUW_Waypoint_Spatial

var _world_position : Vector3
var _transformer 
var _camera : Camera

func set_transformer(transformer):
	_transformer = transformer


func get_world_position() -> Vector3:
	return _world_position


func set_world_position(pos : Vector3):
	pos = _transformer.transform(pos)
	transform.origin = pos
	_world_position = pos.floor()


func set_camera(camera : Camera):
	_camera = camera


func set_path(path : Array) -> void:

	path.pop_back()
	if !_path.empty():
		for point_id in range(1, len(_path)):
			var line = load("res://addons/waypoints/scenes/spatial/line.tscn")
			line = line.instance()
			var previous_point = path[point_id - 1]
			var point = path[point_id]

			var point = _transformer.transform(item)
			line.transform.origin = point - transform.origin
			add_child(line)

func _get_direction(pos : Vector3, pos2 : Vector3):
	var pos_unit = pos.normalized()
	var direction = pos.direction_to(pos2)
	direction.dot()
	match direction:
		0:
