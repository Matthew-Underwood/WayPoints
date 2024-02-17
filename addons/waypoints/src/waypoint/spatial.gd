extends Spatial

class_name MUW_Waypoint_Spatial

var _world_position : Vector2
var _line_nodes = []
var _meta_data : Dictionary
#var _points : MUW_Points
var _waypoint_data : MUW_Waypoint_Data

func set_waypoint_data(waypoint_data : MUW_Waypoint_Data):
	_waypoint_data = waypoint_data


func update_path():
	pass
	#TODO how does this fit in with new system


#TODO remove this when sure its refactored
#func set_points(points : MUW_Points):
#	_points = points


func get_world_position() -> Vector2:
	return _waypoint_data.get_world_position()


#TODO what are we doing with this?
func set_id(id : String):
	$Label3D.text = id


#func set_path(path : Array) -> void:
#	if get_parent() == null:
#		yield(self, "ready")
#	transform.origin = path[len(path) - 1]
#	$Line.create_line(path, _points)
