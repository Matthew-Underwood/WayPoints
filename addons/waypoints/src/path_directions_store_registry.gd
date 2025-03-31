class_name MUW_Directions_Path_Store_Registry

var _connected_path_store
var _static_path_store

func _init(static_path_store : MUW_Directions_Path_Store, connected_path_store : MUW_Directions_Path_Store):

    _static_path_store = static_path_store
    _connected_path_store = connected_path_store


func get_static_path_store() -> MUW_Directions_Path_Store:

    return _static_path_store


func get_connected_path_store() -> MUW_Directions_Path_Store:

    return _connected_path_store


func set_static_path_store(static_path_store : MUW_Directions_Path_Store):

    _static_path_store = static_path_store


func set_connected_path_store(connected_path_store : MUW_Directions_Path_Store):

    _connected_path_store = connected_path_store
