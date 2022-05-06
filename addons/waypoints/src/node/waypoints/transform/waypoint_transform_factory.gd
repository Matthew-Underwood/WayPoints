class_name Waypoint_Transform_Factory

enum Transform_Type {TILEMAP_TRANSFORM, MESH_TRANSFORM}
var _transforms = []

func _init(tilemap : TileMap):
    var tilemap_transform = load("res://addons/waypoints/src/node/waypoints/transform/tilemap_waypoint_transform.gd")
    var mesh_transform = load("res://addons/waypoints/src/node/waypoints/transform/mesh_waypoint_transform.gd")
    
    tilemap_transform = tilemap_transform.new(tilemap)
    mesh_transform = mesh_transform.new()
    _transforms = {
        Transform_Type.TILEMAP_TRANSFORM : tilemap_transform,
        Transform_Type.MESH_TRANSFORM : mesh_transform
    }


func create(transform_type : int):
    return _transforms[transform_type]