class_name MUW_Waypoint_Switch_Input_Manager_Factory

var _static_path_store
var _connected_path_store


func _init(static_path_store, connected_path_store):

    _static_path_store = static_path_store
    _connected_path_store = connected_path_store


func create(master_node):
    
	var waypoint_input_scene = preload("res://addons/waypoints/assets/scenes/waypoint_input_managers.tscn")
    master_node.add_child(waypoint_input_scene)

    var waypoint_switch_input_manager = $InputSwitchManager
    var static_waypoint_input_manager = $StaticWaypointInputManager
    var connected_waypoint_input_manager = $ConnectedWaypointInputManager

    var waypoint_manager = MUW_Waypoint_Manager.new(static_waypoint_input_manager, connected_waypoint_input_manager, static_waypoint_store, connected_waypoint_store)
    input_switch_manager.set_waypoint_manager(waypoint_manager)


    
