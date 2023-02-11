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

	var line_dot
	if !path.empty():
		for point_id in range(1, len(path)):
			var line = load("res://addons/waypoints/scenes/spatial/line.tscn")
			line = line.instance()
			var point = path[point_id]
			var previous_point = path[point_id - 1]
			var radians = _get_facing_angle(line.transform, previous_point, point)
			line.transform = line.transform.rotated(Vector3(0, 1, 0), radians)
			point = _transformer.transform(point)
			line.transform.origin = point - transform.origin
			add_child(line)

func _get_facing_angle(transform : Transform, pos : Vector3, pos2 : Vector3):
	var facing = transform.basis.z
	var y_axis = transform.basis.y
	var direction = pos - pos2
	var rad = facing.signed_angle_to(direction, y_axis)
	print(rad2deg(rad))
	return rad
	


