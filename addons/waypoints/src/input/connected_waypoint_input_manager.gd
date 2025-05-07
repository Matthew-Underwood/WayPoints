extends Spatial

class_name MUW_Connected_Waypoint_Input_Manager

var _waypoints : MUW_Waypoints_Operations
var _viewport 


func set_waypoints(waypoints):
	_waypoints = waypoints


func set_viewport(viewport):
	_viewport = viewport


func _input(event):

	if Input.is_action_released("select_waypoint"):
		var click_pos = _viewport.get_mouse_position()
		_waypoints.create(click_pos)
			
	if Input.is_action_pressed("select_waypoint"):
		var dragged_pos = _viewport.get_mouse_position()
		_waypoints.update(dragged_pos)

	if Input.is_action_released("remove_waypoint"):
		_waypoints.remove()


