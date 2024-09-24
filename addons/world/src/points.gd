class_name MUW_Points


# key1 world_point vec3

var _points = {}

func has_point(point : Vector3) -> bool:
    return _points.has(point)


func get_point(point : Vector3) -> Dictionary:
    return _points[point]


func add_point(point : Vector3, data : Dictionary):
    _points[point] = data