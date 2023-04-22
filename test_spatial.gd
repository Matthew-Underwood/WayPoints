extends Spatial

var _waypoints : Spatial
var _waypoint_id
var _world : MUW_World
var _viewport : Viewport

# Called when the node enters the scene tree for the first time.
func _ready():

	var world_mesh = $MeshInstance
	_viewport = get_viewport()
	var world = get_world()
	var world_size = Vector2(10, 10)
	var obstacles = []
	var slope_vectors = [
		Vector2(4, 3), Vector2(5, 3), Vector2(6, 3), Vector2(3, 4), Vector2(3, 5), Vector2(3, 6),
		Vector2(4, 7), Vector2(5, 7), Vector2(6, 7), Vector2(7, 4), Vector2(7, 5), Vector2(7, 6)
	]

	#TODO create master factory
	var rc = RayCast.new()
	rc.enabled = true
	rc.cast_to = Vector3(0, -10, 0)
	add_child(rc)

	var tile_data = {}

	for x in range(world_size.x):
		for y in range(world_size.y):
			tile_data[Vector2(x, y)] = {"type" : MUW_Tiles_Processor_3d.TILE_TYPE_FLAT}
	
	tile_data[Vector2(3, 3)] = {"type" : MUW_Tiles_Processor_3d.TILE_TYPE_CORNER}
	tile_data[Vector2(7, 7)] = {"type" : MUW_Tiles_Processor_3d.TILE_TYPE_CORNER}
	tile_data[Vector2(7, 3)] = {"type" : MUW_Tiles_Processor_3d.TILE_TYPE_CORNER}
	tile_data[Vector2(3, 3)] = {"type" : MUW_Tiles_Processor_3d.TILE_TYPE_CORNER}

	for slope_vector in slope_vectors:
		tile_data[slope_vector] = {"type" : MUW_Tiles_Processor_3d.TILE_TYPE_SLOPE}

	var tile_processor = MUW_Tiles_Processor_3d.new(rc)
	var tiles_factory = MUW_Tiles_Factory.new(tile_processor, tile_data)

	_world = MUW_World_Factory.new(tiles_factory, world_size, obstacles).create_spatial(_viewport.get_camera(), world)
	var aStar = AStar.new()
	var pathing = MUP_Pathing_Factory.new(aStar, _world).create()
	_waypoints = MUW_Waypoints_Factory.new(pathing, _world).create_spatial()
	add_child(_waypoints)

	
	
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
