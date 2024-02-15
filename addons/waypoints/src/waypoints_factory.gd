class_name MUW_Waypoints_Factory

var _pathing : MUP_Pathing
var _waypoint_factory : MUW_Waypoint_Factory


func _init(pathing : MUP_Pathing, waypoint_factory : MUW_Waypoint_Factory):
	_pathing = pathing
	_waypoint_factory = waypoint_factory


func create_3d(camera : Camera, world : World) -> MUW_WayPoints:
	var mesh_picking = MUW_Mesh_Picker.new(camera, world)
	var transformer = MUW_Transformers_Screen_Mesh.new(mesh_picking)
	return MUW_WayPoints.new(_waypoint_factory, _pathing, transformer)


func create_2d(tilemap : TileMap) -> MUW_WayPoints:
	var transformer = MUW_Transformers_Screen_Tilemap.new(tilemap)
	return  MUW_WayPoints.new(_waypoint_factory, _pathing, transformer)
