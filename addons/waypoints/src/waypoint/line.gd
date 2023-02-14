extends Spatial


var _point_position : Vector3
var _point_position2 : Vector3
var _waypoint_position : Vector3


func _ready():
	var z_axis = transform.basis.z
	var y_axis = transform.basis.y
	var direction = _point_position - _point_position2
	var angle_radians = z_axis.signed_angle_to(direction, y_axis)
	var angle_degrees = abs(round(rad2deg(angle_radians)))

	if angle_degrees == 45 || angle_degrees == 135:
		scale = Vector3(1, 1, 1.4)
	
	transform = transform.rotated(y_axis, angle_radians)
	transform.origin = _point_position2 - _waypoint_position


func set_point_positions(point_position : Vector3, point_position2 : Vector3):
	_point_position = point_position
	_point_position2 = point_position2


func set_waypoint_position(pos : Vector3):
	_waypoint_position = pos