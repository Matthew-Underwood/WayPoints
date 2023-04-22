class_name MUW_Waypoints_Factory

var _pathing : MUP_Pathing
var _world : MUW_World

func _init(
	pathing : MUP_Pathing,
	world : MUW_World
):
	_world = world
	_pathing = pathing

func create_2d() -> Node2D:

	var waypoint_packed = preload("res://addons/waypoints/scenes/2d/waypoint.tscn")
	var waypoints_packed = preload("res://addons/waypoints/scenes/2d/waypoints.tscn")
	return _create_waypoints(waypoint_packed, waypoints_packed)

func create_spatial() -> Spatial:
	
	var waypoint_packed = preload("res://addons/waypoints/scenes/spatial/waypoint.tscn")
	var waypoints_packed = preload("res://addons/waypoints/scenes/spatial/waypoints.tscn")
	return _create_waypoints(waypoint_packed, waypoints_packed)

func _create_waypoints(waypoint_packed : PackedScene, waypoints_packed : PackedScene):

	var waypoint_factory = MUW_Waypoint_Factory.new(waypoint_packed)
	var waypoints = waypoints_packed.instance()
	waypoints.set_waypoint_factory(waypoint_factory)
	waypoints.set_world(_world)
	waypoints.set_pathing(_pathing)
	return waypoints
