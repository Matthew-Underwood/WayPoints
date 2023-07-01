extends Spatial

var _waypoint_id
var _world : MUW_World
var _waypoints : Spatial
var _viewport : Viewport

# Called when the node enters the scene tree for the first time.
func _ready():
	_viewport = get_viewport()
	_world = MUW_World_Factory.new().create_3d(Vector3(0, -10, 0), self, _viewport.get_camera(), get_world())
	_waypoints = _world.get_waypoints()
	
	
func _unhandled_input(event):

	if Input.is_action_just_pressed("confirm_click"):
		
		var mouse_click = _viewport.get_mouse_position()
		if !valid_click(mouse_click):
			return
		
		_waypoint_id = _waypoints.get_waypoint_id_from_pos(mouse_click)
		if _waypoint_id == null:

			_waypoints.create_waypoint(mouse_click)
			return
			
	if Input.is_action_pressed("confirm_click") && _waypoint_id != null:
		var mouse_drag = _viewport.get_mouse_position()
		var waypoint_id = _waypoints.get_waypoint_id_from_pos(mouse_drag)
		if !valid_click(mouse_drag) || waypoint_id != null:
			return
		
		_waypoints.update_waypoints_from_pos(_waypoint_id, mouse_drag)
	
	if Input.is_action_just_pressed("remove_waypoint") && _waypoint_id != null:
		_waypoints.remove_waypoint(_waypoint_id)
		_waypoint_id = null
		
		
func valid_click(pos : Vector2) -> bool:
	#TODO need to fix bug where you can create waypoint on player position. This needs handling somewhere else
	return _world.is_walkable(pos)
