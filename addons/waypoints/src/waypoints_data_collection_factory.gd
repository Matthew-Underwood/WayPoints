class_name MUW_Waypoints_Data_Collection_Factory

var _waypoint_data_factory : MUW_Waypoint_Data_Factory
var _data_store_factory : MUW_Path_Directions_Store_Factory

func _init(waypoint_data_factory : MUW_Waypoint_Data_Factory, data_store_factory : MUW_Path_Directions_Store_Factory):

	_waypoint_data_factory = waypoint_data_factory
	_data_store_factory = data_store_factory


func create(persist = true) -> MUW_Waypoints_Data_Collection:

	var data_store = _data_store_factory.create()
	return MUW_Waypoints_Data_Collection.new(_waypoint_data_factory, data_store, persist)





