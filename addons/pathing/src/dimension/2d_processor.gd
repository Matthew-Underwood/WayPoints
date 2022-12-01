class_name MUP_DIMENSION_2D_PROCESSOR

func point_to_position(point: Vector2) -> Vector3:
    return Vector3(point.x, point.y, 0)


func position_to_point(pos : Vector3) -> Vector2:
    return Vector2(pos.x, pos.y)