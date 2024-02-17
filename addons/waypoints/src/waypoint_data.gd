class_name MUW_Waypoint_Data

var _path : PoolVector3Array
var _world_position : Vector2


func _init(path : PoolVector3Array, world_position : Vector2):
    _path = path
    _world_position = world_position


func get_path() -> PoolVector3Array:
    return _path


func get_world_position() -> Vector2:
    return _world_position

