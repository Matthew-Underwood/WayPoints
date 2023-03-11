extends Spatial

var _waypoints : Spatial
var _waypoint_id
var _world : MUW_World
var _viewport : Viewport

# Called when the node enters the scene tree for the first time.
func _ready():

	var world_mesh = $MeshInstance2
	_viewport = get_viewport()
	var world = get_world()
	var world_size = Vector2(10, 10)
	var obstacles = []

	#TODO create master factory
	var rc = RayCast.new()
	rc.enabled = true
	rc.cast_to = Vector3(0, -10, 0)
	add_child(rc)

	var tile_processor = MUW_Tiles_Processor_3d.new(rc)
	var tiles_factory = MUW_Tiles_Factory.new(tile_processor)



	_world = MUW_World_Factory.new(tiles_factory, world_size, obstacles).create_spatial(_viewport.get_camera(), world)
	var aStar = AStar.new()
	var pathing = MUP_Pathing_Factory.new(aStar, _world).create()
	
	var packed_waypoint = preload("res://addons/waypoints/scenes/spatial/waypoint.tscn")
	var waypoint_factory = MUW_Spatial_Waypoint_Factory.new(packed_waypoint)
	_waypoints = MUW_Waypoints_Factory.new(
		pathing,
		_world,
		self,
		waypoint_factory
	).create_spatial()

	
	
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
