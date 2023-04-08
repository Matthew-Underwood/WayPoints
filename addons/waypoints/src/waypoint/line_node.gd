extends MeshInstance

class_name MUW_WayPoint_Line


func create_line(points : Array):

	var org = to_global(get_parent_spatial().transform.origin)
	var z_axis = transform.basis.z
	var y_axis = transform.basis.y
	var global_line_points = PoolVector3Array()

	for p in range(1, len(points)):
		var src = points[p - 1] - org
		var dest = points[p] - org
		var direction = dest - src
		direction = Vector3(direction.x, 0, direction.z)
		var y_diff = dest.y - src.y
		var distance_to_src = dest.distance_to(src)

		var line_points = [
			Vector3(-0.05, 0.02, 0),
			Vector3(0.05, 0.02, 0),
			Vector3(0.05, y_diff + 0.02, distance_to_src),
			Vector3(-0.05, 0.02, 0),
			Vector3(0.05, y_diff + 0.02, distance_to_src),
			Vector3(-0.05, y_diff + 0.02, distance_to_src)
		]
		var angle_radians = z_axis.signed_angle_to(direction, y_axis)
		transform.origin = src
		rotate_object_local(y_axis, angle_radians)
		for l in line_points:
			global_line_points.append(to_global(l))	

		set_identity()

	var array_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = global_line_points
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	mesh = array_mesh
	var line_material = load("res://line.tres")
	set_surface_material(0, line_material)
