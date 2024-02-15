class_name MUW_WayPoint

var _points : Array
var _id : int
var _world_position : Vector2

func _init(id : int, points : Array, world_position : Vector2):
    _id = id
    _points = points
    _world_position = world_position


func get_points() -> Array:
    return _points


func get_id() -> int:
    return _id


func get_world_position() -> Vector2:
    return _world_position


func set_world_position(world_position) -> void:
    _world_position = world_position


func set_points(points) -> void:
    _points = points