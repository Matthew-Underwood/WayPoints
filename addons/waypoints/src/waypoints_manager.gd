class_name MUW_Waypoint_Manager

var _connected_waypoints_input : MUW_Connected_Waypoint_Input_Manager
var _static_waypoints_input : MUW_Static_Waypoint_Input_Manager
var _static_directions_store : MUW_Path_Directions_Store 
var _connected_directions_store : MUW_Path_Directions_Store 


func _init(static_waypoints_input, connected_waypoints_input, static_directions_store, connected_directions_store):

    _static_waypoints_input = static_waypoints_input
    _connected_waypoints_input = connected_waypoints_input
    _static_directions_store = static_directions_store
    _connected_directions_store = connected_directions_store


func switch_on_confirm():

    var static_active = _static_waypoints_input.is_visible()
    var connected_active = _connected_waypoints_input.is_visible()

    if connected_active:

        var connected_directions = _connected_directions_store.get_directions()
        var connected_corners = _connected_directions_store.get_corners()
        
        var static_directions = _static_directions_store.get_directions()
        var static_corners = _static_directions_store.get_corners()

        _static_directions_store.add_directions(static_directions)
        _static_directions_store.add_corners(static_corners)

        _connected_waypoints_input.set_visible(false)
        _static_waypoints_input.set_visible(true)


func switch_on_cancel():

    var connected_active = _connected_waypoints_input.is_visible()

    if connected_active:
        _connected_waypoints_input.set_visible(false)
        _static_waypoints_input.set_visible(true)


