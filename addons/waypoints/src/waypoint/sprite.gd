extends AnimatedSprite

class_name MUW_Waypoint_Sprite

var _path = []
var _world_position : Vector3
var _previous_frame : int setget set_previous_frame
var _transformer 
var _meta_data : Dictionary

func get_world_position() -> Vector3:
	return _world_position


func set_world_position(pos : Vector3):
	transform.origin = _transformer.transform(pos)
	_world_position = pos


func set_id(id : String):
	$Label.text = id


func set_meta_data(meta_data : Dictionary):
	_meta_data = meta_data


func set_transformer(transformer):
	_transformer = transformer


func _input(event):
	if event.is_action_released("confirm_click") && get_frame() == 1:
		var waypoints = get_tree().get_nodes_in_group("waypoint")
		for waypoint in waypoints:
			waypoint.set_frame(0)
		set_previous_frame(2)


func exit_waypoint():
	set_frame(_previous_frame)


func enter_waypoint():
	_previous_frame = get_frame()
	set_frame(1)
	

func set_previous_frame(frame : int) -> void:
	_previous_frame = frame
	set_frame(frame)


func _draw():
	if !_path.empty():
		for point in range(1, len(_path)):
			var start_world_position = _path[point - 1]
			var end_world_position = _path[point]
			draw_line(start_world_position, end_world_position, Color.green, 1, true)
			draw_circle(end_world_position, 2, Color.green)
			
	
func set_path(path : Array) -> void:
	_path = []
	for item in path:
		_path.append(_transformer.transform(item) - transform.origin)
	update()
