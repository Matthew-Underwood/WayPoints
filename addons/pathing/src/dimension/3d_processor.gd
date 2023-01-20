class_name MUP_Dimension_3D_Processor

func point_to_position(point : Vector2) -> Vector3:
	#TODO work out how to calculcate y
	return Vector3(point.x, 0.1, point.y)


func position_to_point(pos : Vector3) -> Vector2:
	return Vector2(pos.x, pos.z)
