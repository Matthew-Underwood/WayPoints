extends Spatial

class_name MUW_Waypoint_Switch_Input_Manager 

var _waypoint_manager : MUW_Waypoint_Manager


func set_waypoint_manager(waypoint_manager):

    _waypoint_manager = waypoint_manager


func _input(event):

    if Input.is_action_released("switch_to_connected"):
        _waypoint_manager.switch_on_confirm()
			
    if Input.is_action_released("switch_to_static"):
        _waypoint_manager.switch_on_cancel()


