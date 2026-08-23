extends Spatial

var _viewport
var _static_waypoints
var _connected_waypoints
var _switch_waypoints
var _layer = 0

func _ready():

	_viewport = get_viewport()
	var world = MUW_World_Factory.new().create_3d(Vector3(0, -10, 0), self, _viewport.get_camera(), get_world())
	_connected_waypoints = world.create_waypoints(self, _viewport.get_camera(), get_world())
	_connected_waypoints.set_layer(_layer)


func set_viewport(viewport):

	_viewport = viewport


func _input(event):

	if Input.is_action_just_pressed("switch_layer_0"):
		_connected_waypoints.set_layer(0)

	if Input.is_action_just_pressed("switch_layer_1"):
		_connected_waypoints.set_layer(1)

	if Input.is_action_just_pressed("select_waypoint"):

		var click_pos = _viewport.get_mouse_position()

		if _connected_waypoints.is_empty():
			_connected_waypoints.set_origin(click_pos)
		else:
			_connected_waypoints.create(click_pos)
			
	if Input.is_action_pressed("select_waypoint"):

		var dragged_pos = _viewport.get_mouse_position()
		_connected_waypoints.update(dragged_pos)

	if Input.is_action_just_pressed("remove_waypoint"):

		_connected_waypoints.remove()

	if Input.is_action_just_pressed("cancel_waypoint"):

		_connected_waypoints.cancel()

	if Input.is_action_just_pressed("apply_waypoint"):

		_connected_waypoints.apply()

