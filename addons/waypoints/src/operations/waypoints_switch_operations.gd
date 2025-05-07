class_name MUW_Waypoints_Switch_Operations

var _path_registry : MUW_Path_Directions_Store_Registry
var _connected_active = false
var _static_active = true


func _init(path_registry : MUW_Path_Directions_Store_Registry):

	_path_registry = path_registry


func is_connected_active():

	return _connected_active


func is_static_active():

	return _static_active


func switch():

	var static_store = _path_registry.get_static_path_store()
	var connected_store = _path_registry.get_connected_path_store()

	if !_static_active:
		_update_store(connected_store, static_store)
		_static_active = true
		_connected_active = false

	if !_connected_active:
		_update_store(static_store, connected_store)
		_static_active = false
		_connected_active = true


func cancel():

	if !_static_active:
		_static_active = true
		_connected_active = false


func _update_store(store_from : MUW_Path_Directions_Store, store_to : MUW_Path_Directions_Store):

	var directions = store_from.get_all_directions()
	var corners = store_from.get_all_corners()

	store_to.set_directions(directions)
	store_to.set_corners(corners) 
