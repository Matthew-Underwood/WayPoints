extends Spatial

var _viewport
var _static_waypoints
var _connected_waypoints
var _switch_waypoints

func _ready():

	_viewport = get_viewport()
	var world = MUW_World_Factory.new().create_3d(Vector3(0, -10, 0), self, _viewport.get_camera(), get_world())
	var waypoints_registry = world.create_waypoints(self, _viewport.get_camera(), get_world())

	_static_waypoints = waypoints_registry.get_static_waypoints()
	_connected_waypoints = waypoints_registry.get_connected_waypoints()
	_switch_waypoints = waypoints_registry.get_switch_waypoints()


func set_viewport(viewport):

	_viewport = viewport


func _input(event):

	if _switch_waypoints.is_static_active():

		if Input.is_action_just_pressed("select_waypoint"):

			var click_pos = _viewport.get_mouse_position()
			_static_waypoints.create(click_pos)
				
		if Input.is_action_just_pressed("remove_waypoint"):

			_static_waypoints.remove()

	if _switch_waypoints.is_connected_active():

		if Input.is_action_just_pressed("select_waypoint"):

			var click_pos = _viewport.get_mouse_position()
			_connected_waypoints.create(click_pos)
				
		if Input.is_action_pressed("select_waypoint"):

			var dragged_pos = _viewport.get_mouse_position()
			_connected_waypoints.update(dragged_pos)

		if Input.is_action_just_pressed("remove_waypoint"):

			_connected_waypoints.remove()

		if Input.is_action_just_pressed("cancel_waypoint"):

			_switch_waypoints.cancel()

	if Input.is_action_just_pressed("switch_waypoint"):

		_switch_waypoints.switch()

