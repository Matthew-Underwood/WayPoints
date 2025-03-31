class_name MUW_Waypoints_Operations_Registry


var _static_waypoint_operations : MUW_Static_Waypoint_Operations
var _connected_waypoint_operations : MUW_Connected_Waypoint_Operations
var _switch_waypoint_operations : MUW_Waypoints_Switch_Operations


func _init(
    static_waypoint_operations : MUW_Static_Waypoint_Operations,
    connected_waypoint_operations : MUW_Connected_Waypoint_Operations,
    switch_waypoint_operations : MUW_Waypoints_Switch_Operations
):

    _static_waypoint_operations = static_waypoint_operations
    _connected_waypoint_operations = connected_waypoint_operations
    _switch_waypoint_operations = switch_waypoint_operations


func get_static_waypoints() -> MUW_Static_Waypoint_Operations:

    return _static_waypoint_operations


func get_connected_waypoints() -> MUW_Connected_Waypoint_Operations:

    return _connected_waypoint_operations


func get_switch_waypoints() -> MUW_Waypoints_Switch_Operations:

    return _switch_waypoint_operations

