class_name MUW_Sprite_Waypoint_Factory

var _transformer
var _packed_waypoint

func _init(
    transformer : MUW_Waypoint_Transformers_Tilemap,
    packed_waypoint
):
	_transformer = transformer
	_packed_waypoint = packed_waypoint


func create(waypoint_override):
	var waypoint = _packed_waypoint.instance()
	
	if waypoint_override != null:
		waypoint.set_script(waypoint_override) 
	waypoint.set_transformer(_transformer)
	return waypoint


