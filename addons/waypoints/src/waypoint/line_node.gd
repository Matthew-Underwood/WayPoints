extends MeshInstance

class_name MUW_WayPoint_Line

func create_line(src : Vector3, dest : Vector3) -> Array:

	var test = dest.distance_to(src)
	var line_points = [
		Vector3(-0.05, 0.02, 0),
		Vector3(0.05, 0.02, 0),
		Vector3(0.05, 0.02, test),
		Vector3(-0.05, 0.02, 0),
		Vector3(0.05, 0.02, test),
		Vector3(-0.05, 0.02, test)
	]
	var z_axis = transform.basis.z
	var y_axis = transform.basis.y
	var direction = dest - src
	var angle_radians = z_axis.signed_angle_to(direction, y_axis)
	print(src)
	print(dest)
	print(rad2deg(angle_radians))
	transform.origin = src
	rotate_object_local(y_axis, angle_radians)
	for v in range(len(line_points)):
		line_points[v] = to_global(line_points[v])
	return line_points
	
