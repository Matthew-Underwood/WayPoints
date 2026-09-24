class_name MUW_Waypoints_Data_Collection_Factory

var _waypoint_data_factory : MUW_Waypoint_Data_Factory

func _init(waypoint_data_factory : MUW_Waypoint_Data_Factory):

	_waypoint_data_factory = waypoint_data_factory


func create(config : Array) -> MUW_Waypoints_Data_Collection:

	var data_store_factory = MUW_Path_Directions_Store_Factory.new()
	var data_store = data_store_factory.create(config)
	return MUW_Waypoints_Data_Collection.new(_waypoint_data_factory, data_store)
