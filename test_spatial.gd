extends Spatial

var _waypoints : Spatial
var _waypoint_id
var _world : MUP_World
var _viewport : Viewport

# Called when the node enters the scene tree for the first time.
func _ready():
	_viewport = get_viewport()
	#TODO create master factory
	var world = get_world()
	_world = MUP_World_Factory.new(Vector2(10, 10)).create_spatial(_viewport.get_camera(), world)
	var aStar = AStar.new()
	var waypoint_transformer_factory = MUW_Waypoint_Transformer_Factory.new()
	var pathing_factory = MUP_Pathing_Factory.new(aStar)
	_waypoints = (MUW_Waypoints_Factory.new(pathing_factory, _world, waypoint_transformer_factory, self)).create_spatial()

	
	
func _unhandled_input(event):

	print(_viewport.get_mouse_position())
