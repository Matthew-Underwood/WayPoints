class_name MUW_Waypoints_Factory

var _pathing : MUP_Pathing
var _waypoint_data_factory : MUW_Waypoint_Data_Factory
var _structure

func _init(pathing : MUP_Pathing, waypoint_data_factory : MUW_Waypoint_Data_Factory, structure):
	_pathing = pathing
	_waypoint_data_factory = waypoint_data_factory
	_structure = structure


func create(transformer) -> MUW_Waypoints:

	return MUW_Waypoints.new(_pathing, _waypoint_data_factory, transformer, _structure)

