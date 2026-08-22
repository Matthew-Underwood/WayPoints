class_name MUW_Static_Waypoints_Operations

var _waypoints
var _world : MUW_World


func _init(waypoints, world : MUW_World):

	_waypoints = waypoints
	_world = world


func set_layer(id):
	_waypoints.set_layer(id)


func create(pos):
	
	if !self._valid_click(pos):
		return
	
	_waypoints.create_waypoint(pos)


func remove(pos : Vector2):
	_waypoints.remove_waypoint(pos)


func _valid_click(pos : Vector2) -> bool:
	#TODO need to fix bug where you can create waypoint on player position. This needs handling somewhere else
	return _world.is_walkable(pos)
