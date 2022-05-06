class_name Waypoints_Factory

var _pathing : Pathing
var _world : MU_World
var _waypoint_transform
var _waypoints_packed : PackedScene

func _init(tilemap : TileMap, world : MU_World):
	var pathing_factory = load("res://addons/pathing/src/pathing/pathing_factory.gd")
	var waypoint_transform_factory = load("res://addons/waypoints/src/node/waypoints/transform/waypoint_transform_factory.gd")
	_waypoints_packed = preload("res://addons/waypoints/scenes/waypoints.tscn")

	_waypoint_transform = (waypoint_transform_factory.new(tilemap)).create(0)
	_world = world
	_pathing = (pathing_factory.new()).create(_world)


func create() -> WayPoints:
	var waypoints = _waypoints_packed.instance()
	waypoints.set_world(_world)
	waypoints.set_pathing(_pathing)
	waypoints.set_waypoint_transform(_waypoint_transform)
	return waypoints
