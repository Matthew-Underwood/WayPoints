class_name MUW_Waypoint_Transformers_Mesh

func transform(pos : Vector3) -> Vector3:
	var x = floor(pos.x) + 0.5
	var z = floor(pos.z) + 0.5
	return Vector3(x, 0.1, z)
