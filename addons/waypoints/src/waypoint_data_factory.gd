class_name MUW_Waypoint_Data_Factory

var _config : Dictionary

func _init(config : Dictionary):

	_config = config


func create(path : PoolVector3Array, pos : Vector2, layer : int) -> MUW_Waypoint_Data:

	var tiles_per_point = _config["layers"][layer].tiles_per_point
	return MUW_Waypoint_Data.new(path, pos, tiles_per_point)
