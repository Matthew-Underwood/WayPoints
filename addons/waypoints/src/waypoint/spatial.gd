extends Spatial

class_name MUW_Waypoint_Spatial

var _world_position : Vector2
var _line_nodes = []
var _meta_data : Dictionary
var _points : MUW_Points

func set_points(points : MUW_Points):
	_points = points

func get_world_position() -> Vector2:
	return _world_position


func set_world_position(world_pos : Vector2):
	_world_position = world_pos


func set_id(id : String):
	$Label3D.text = id


func set_meta_data(meta_data : Dictionary):
	_meta_data = meta_data


func set_path(path : Array) -> void:
	yield(self, "ready")
	transform.origin = path[len(path) - 1]
	$Line.create_line(path, _points)
