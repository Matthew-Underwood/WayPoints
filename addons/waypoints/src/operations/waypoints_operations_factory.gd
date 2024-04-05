class_name MUW_Waypoints_Operations_Factory

var _waypoints_factory : MUW_Waypoints_Factory

func _init(waypoints_factory : MUW_Waypoints_Factory):
	_waypoints_factory = waypoints_factory


func create_3d(camera : Camera, world : World, map_world : MUW_World):
	var waypoints = _waypoints_factory.create_3d_paths(camera, world)
	return MUW_Waypoints_Operations.new(waypoints, map_world)