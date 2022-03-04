extends AnimatedSprite

class_name WayPoint
var _path = []
var _selected = false setget set_selected, is_selected


func _input(event):
	if event.is_action_released("confirm_click") && get_frame() == 1:
		var waypoints = get_tree().get_nodes_in_group("waypoint")
		for waypoint in waypoints:
			waypoint.set_selected(false)
			waypoint.exit_waypoint()
		
		set_frame(2)
		set_selected(true)


func exit_waypoint():
	if is_selected(): 
		set_frame(2)
	else:
		set_frame(0)


func enter_waypoint():
	set_frame(1)
	

func is_selected() -> bool:
	return _selected


func set_selected(selected : bool):
	_selected = selected

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