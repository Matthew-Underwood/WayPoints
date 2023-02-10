class_name MUP_Dimension_3D_Processor

var _height_resolver : MUW_Resolver_Height

func _init(height_resolver : MUW_Resolver_Height):
	_height_resolver = height_resolver


func point_to_position(point : Vector2) -> Vector3:
	return Vector3(point.x, _height_resolver.resolve(point), point.y)


func position_to_point(pos : Vector3) -> Vector2:
	return Vector2(pos.x, pos.z)
