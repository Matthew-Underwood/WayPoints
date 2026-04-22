class_name MUW_Waypoints_Data_Collection

var _waypoints = []
var _waypoint_data_factory : MUW_Waypoint_Data_Factory
var _persist : bool
var _path_directions_store : MUW_Path_Directions_Store 

func _init(waypoint_data_factory : MUW_Waypoint_Data_Factory, path_directions_store : MUW_Path_Directions_Store, persist : bool):

	_waypoint_data_factory = waypoint_data_factory
	_path_directions_store = path_directions_store
	_persist = persist


func get_store() -> MUW_Path_Directions_Store:

	return _path_directions_store


func set_store(store : MUW_Path_Directions_Store):

	_path_directions_store = store


func get_data(id : int) -> MUW_Waypoint_Data:

	return _waypoints[id]


func get_size() -> int:

	return _waypoints.size()


func is_empty() -> bool:

	return _waypoints.empty()


func update(id : int, path : PoolVector3Array, pos : Vector2):

	_waypoints[id].set_world_pos(pos)
	_waypoints[id].set_path(pos)
	_calculate_directions()


func empty():

	_waypoints = []


func remove(id : int):

	_waypoints.remove(id)
	_calculate_directions()


func add_direction(path : PoolVector3Array, pos : Vector2):

	var waypoint_data = _waypoint_data_factory.create(path, pos)
	_waypoints.append(waypoint_data)
	_calculate_directions()


func _calculate_directions():
	
	var flattened_directions = []
	var size = _waypoints.size()

	if !_persist:
		_path_directions_store.empty()

	for id in range(size):
		var waypoint_data = _waypoints[id]
		var path = waypoint_data.get_path_as_vec2()
		for current_id in range(path.size()): 
			# Skip if it is the last point and NOT the last waypoint 
			if id != size - 1 && current_id == path.size() - 1:
				continue
			flattened_directions.append(path[current_id])
			
	var flattened_size = flattened_directions.size()

	for id in range(flattened_size):
		var previous_id = id - 1
		var next_id = id + 1
		var current_pos = flattened_directions[id] 
		var previous_pos = null if previous_id < 0 else flattened_directions[previous_id]
		var next_pos = null if next_id >= flattened_size else flattened_directions[next_id]
		if previous_pos != null:
			_path_directions_store.add_direction(current_pos, previous_pos)
		if next_pos != null:
			_path_directions_store.add_direction(current_pos, next_pos)
