extends Node2D

var _waypoints : Node2D
var _waypoint_id
var _world : MUW_World

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#TODO create master factory
	var tilemap = get_node("TileMap")
	var dimension_processor = MUP_Dimension_Processor_Factory.new(MUW_Resolver_Height_Factory.new()).create_2d()
	_world = MUW_World_Factory.new(dimension_processor,Vector2(10, 10), tilemap.get_used_cells_by_id(0)).create_2d(tilemap)
	var aStar = AStar.new()
	var waypoint_transformer_factory = MUW_Waypoint_Transformer_Factory.new()
	var pathing_dimension = MUP_Dimension_2D_Processor.new()
	var pathing_factory = MUP_Pathing_Factory.new(aStar, pathing_dimension)
	var pathing = pathing_factory.create(_world)

	var transformer = MUW_Waypoint_Transformers_Tilemap.new(tilemap)
	var packed_waypoint = preload("res://addons/waypoints/scenes/2d/waypoint.tscn")
	var waypoint_factory = MUW_Sprite_Waypoint_Factory.new(transformer, packed_waypoint)
	_waypoints = MUW_Waypoints_Factory.new(
		pathing,
		_world,
		waypoint_transformer_factory,
		self,
		waypoint_factory
	).create_2d(tilemap)

	
	
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
	#TODO need to fix bug where you can create waypoint on player position. This needs handling somewhere else
	return _world.is_walkable(pos)
