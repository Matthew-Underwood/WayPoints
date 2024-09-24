extends Spatial

var _viewport
var _waypoints : MUW_Waypoints_Operations

# Called when the node enters the scene tree for the first time.
func _ready():
	_viewport = get_viewport()
	var world = MUW_World_Factory.new().create_3d(Vector3(0, -10, 0), self, _viewport.get_camera(), get_world())
	_waypoints = world.create_waypoints(self, _viewport.get_camera(), get_world())
	
	
	
func _unhandled_input(event):

	if Input.is_action_just_pressed("confirm_click"):
		var click_pos = _viewport.get_mouse_position()
		_waypoints.create(click_pos)
			
	
	if Input.is_action_pressed("confirm_click"):
		var dragged_pos = _viewport.get_mouse_position()
		_waypoints.update(dragged_pos)

	
	if Input.is_action_just_pressed("remove_waypoint"):
		_waypoints.remove()
