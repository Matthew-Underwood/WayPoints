class_name MUW_Spatial_Waypoint_Factory

var _transformer : MUW_Waypoint_Transformers_Mesh
var _packed_waypoint
var _line_factory : MUW_Factory_Line

func _init(
	transformer : MUW_Waypoint_Transformers_Mesh,
	packed_waypoint,
	line_factory : MUW_Factory_Line
):
	_transformer = transformer
	_packed_waypoint = packed_waypoint
	_line_factory = line_factory

func create(waypoint_override):
	var waypoint = _packed_waypoint.instance()
	if waypoint_override != null:
		waypoint.set_script(waypoint_override)
	waypoint.set_transformer(_transformer)
	waypoint.set_line_factory(_line_factory)
	return waypoint


