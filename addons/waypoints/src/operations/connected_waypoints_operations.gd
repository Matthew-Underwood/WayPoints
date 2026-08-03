class_name MUW_Connected_Waypoints_Operations

var _waypoints
var _world : MUW_World
var _id


func _init(waypoints, world : MUW_World):
	_waypoints = waypoints
	_world = world


func set_layer(id):
	_waypoints.set_layer(id)


func create(pos):
	
	if !self._valid_click(pos):
		return
	
	_waypoints.create_waypoint(pos)


func update(pos):
	if _id == null:
		return
	var waypoint_id = _waypoints.get_waypoint_id_from_pos(pos)
	if !_valid_click(pos) || waypoint_id != null:
		return    
	_waypoints.update_waypoints_from_pos(_id, pos)
	

func remove():
	if _id == null:
		return
	_waypoints.remove_waypoint(_id)
	_id = null


func get(pos):
	return _waypoints.get_waypoint_id_from_pos(pos)


func _valid_click(pos : Vector2) -> bool:
	#TODO need to fix bug where you can create waypoint on player position. This needs handling somewhere else
	return _world.is_walkable(pos)
