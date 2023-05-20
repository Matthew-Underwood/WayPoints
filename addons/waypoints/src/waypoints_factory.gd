class_name MUW_Waypoints_Factory

var _pathing : MUP_Pathing

func _init(pathing : MUP_Pathing):
	_pathing = pathing

func create_3d(waypoints_packed : PackedScene, waypoint_packed : PackedScene, transformer, points : MUW_Points) -> Spatial:
	return _create(waypoints_packed, waypoint_packed, transformer, points)

func create_2d(waypoints_packed : PackedScene, waypoint_packed : PackedScene, transformer) -> Node2D:
	return _create(waypoints_packed, waypoint_packed, transformer)


func _create(waypoints_packed : PackedScene, waypoint_packed : PackedScene, transformer, points = null):

	var waypoint_factory = MUW_Waypoint_Factory.new(waypoint_packed, points)
	var waypoints = waypoints_packed.instance()
	waypoints.set_waypoint_factory(waypoint_factory)
	waypoints.set_transformer(transformer)
	waypoints.set_pathing(_pathing)
	return waypoints
