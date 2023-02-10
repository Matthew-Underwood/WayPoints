class_name MUW_Spatial_Waypoint_Factory

var _transformer : MUW_Waypoint_Transformers_Mesh
var _packed_waypoint
var _camera : Camera

func _init(
    transformer : MUW_Waypoint_Transformers_Mesh,
    packed_waypoint,
    camera : Camera
):
    _transformer = transformer
    _packed_waypoint = packed_waypoint
    _camera = camera

func create(waypoint_override):
    var waypoint = _packed_waypoint.instance()
    if waypoint_override != null:
	    waypoint.set_script(waypoint_override)
    waypoint.set_transformer(_transformer)
    waypoint.set_camera(_camera)
    return waypoint


