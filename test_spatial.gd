extends Spatial

var _waypoints : Spatial
var _waypoint_id
var _world : MUW_World
var _viewport : Viewport

# Called when the node enters the scene tree for the first time.
func _ready():
	_viewport = get_viewport()
	#TODO create master factory
	var world = get_world()
	_world = MUW_World_Factory.new(Vector2(10, 10)).create_spatial(_viewport.get_camera(), world)
	var aStar = AStar.new()
	var world_mesh = $MeshInstance
	var height_resolver = MUW_Resolver_Height_Factory.new().create(world_mesh)
	var pathing_dimension = MUP_Dimension_3D_Processor.new(height_resolver)
	var waypoint_transformer_factory = MUW_Waypoint_Transformer_Factory.new()
	var pathing_factory = MUP_Pathing_Factory.new(aStar, pathing_dimension)
	var pathing = pathing_factory.create(_world)
	
	#TODO what am I going to do with these dependencies
	var transformer = MUW_Waypoint_Transformers_Mesh.new()
	var packed_waypoint = preload("res://addons/waypoints/scenes/spatial/waypoint.tscn")
	var waypoint_factory = MUW_Spatial_Waypoint_Factory.new(transformer, packed_waypoint, get_viewport().get_camera())
	_waypoints = MUW_Waypoints_Factory.new(
		pathing,
		_world,
		waypoint_transformer_factory,
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
