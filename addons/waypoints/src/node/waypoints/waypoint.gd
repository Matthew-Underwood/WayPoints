extends AnimatedSprite

class_name WayPoint
var _path = [] 
var _previous_frame : int setget set_previous_frame


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
	_path = path
	update()
