extends Node2D

var _waypoints : Node
var _origin : Vector2 = Vector2(1,1)
var _waypoint_id
var _world : MU_World

# Called when the node enters the scene tree for the first time.
func _ready():
	var tilemap = get_node("TileMap")
	var world = load("res://addons/pathing/src/world/world.gd")
	var waypoints_factory = load("res://addons/waypoints/src/classes/waypoints_factory.gd")
	
	_world = world.new(Vector2(10, 10), tilemap.get_used_cells_by_id(0), tilemap)
	_waypoints = (waypoints_factory.new(tilemap, _world)).create()
	
	
func _unhandled_input(event):
	
	if Input.is_action_just_pressed("confirm_click"):
		  
		var mouse_click = get_global_mouse_position()
		
		if !valid_click(mouse_click):
			return
		
		_waypoint_id = _waypoints.get_waypoint_id_from_pos(mouse_click)
			
		if _waypoint_id == null:
			_waypoints.create_waypoint(mouse_click)
			return
			
	if Input.is_action_pressed("confirm_click") && _waypoint_id != null:
		var mouse_drag = get_global_mouse_position()
		var waypoint_id = _waypoints.get_waypoint_id_from_pos(mouse_drag)
		if !valid_click(mouse_drag) || waypoint_id != null:
			return
		
		_waypoints.update_waypoints_from_pos(_waypoint_id, mouse_drag)
	
	if Input.is_action_just_pressed("remove_waypoint") && _waypoint_id != null:
		_waypoints.remove_waypoint(_waypoint_id)
		_waypoint_id = null
		
		
func valid_click(pos : Vector2) -> bool:
	return (_origin != pos) && _world.is_walkable(pos)
