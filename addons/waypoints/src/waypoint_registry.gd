class_name MUW_Waypoints_Registry

var _connected_waypoints
var _static_waypoints

func _init(static_waypoints : MUW_Waypoints_Static, connected_waypoints : MUW_Waypoints_Connected):

    _static_waypoints = static_waypoints
    _connected_waypoints = connected_waypoints


func get_static_waypoints() -> MUW_Waypoints_Static:

    return _static_waypoints


func get_connected_waypoints() -> MUW_Waypoints_Connected:

    return _connected_waypoints
