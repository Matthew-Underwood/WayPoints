extends MeshInstance

class_name MUW_WayPoint_Line


func create_line(points : Array, point_resolver : MUW_Points):
	
	var org = to_global(get_parent_spatial().transform.origin)
	var z_axis = transform.basis.z
	var y_axis = transform.basis.y
	var x_axis = transform.basis.x
	var global_line_points = PoolVector3Array()
	var y_offset = 0.04

	for p in range(1, len(points)):
		var src = point_resolver.get_point(points[p - 1])["point"] - org
		var dest = point_resolver.get_point(points[p])["point"] - org
		#var src_normal = point_resolver.get_point(points[p - 1])["normal"] - org
		#var dest_normal = point_resolver.get_point(points[p])["normal"] - org
		#var normal_point = dest_normal - src_normal
		var direction = dest - src
		var distance_to_src = dest.distance_to(src)
		var direction_xz = Vector3(direction.x, 0, direction.z)
		var direction_y = Vector3(direction.x, direction.y, direction.z)
		var line_points = [
			Vector3(-0.05, y_offset, 0),
			Vector3(0.05, y_offset, 0),
			Vector3(0.05, y_offset, distance_to_src),
			Vector3(-0.05, y_offset, 0),
			Vector3(0.05, y_offset, distance_to_src),
			Vector3(-0.05, y_offset, distance_to_src)
		]
		var angle_radians_y = z_axis.signed_angle_to(direction_xz, y_axis)
		transform.origin = src
		rotate_object_local(y_axis, angle_radians_y)
		if direction.y != 0:
			var angle1
			print(direction_y)
			if direction.z != 0 and direction.z > 0 and direction.x != 0 and direction.x > 0:
				angle1 = Vector3(1, 0, 1).signed_angle_to(direction_y, Vector3(1, 0, -1))
			elif direction.z != 0 and direction.z < 0 and direction.x != 0 and direction.x < 0:
				angle1 = Vector3(-1, 0, -1).signed_angle_to(direction_y, Vector3(-1, 0, 1))
			elif direction.z != 0 and direction.z < 0 and direction.x != 0 and direction.x > 0:
				angle1 = Vector3(1, 0, -1).signed_angle_to(direction_y, Vector3(-1, 0, -1))
			elif direction.z != 0 and direction.z > 0 and direction.x != 0 and direction.x < 0:
				angle1 = Vector3(-1, 0, 1).signed_angle_to(direction_y, Vector3(1, 0, 1))
			elif direction.z != 0 and direction.z < 0:
				angle1 = Vector3(0, 0, -1).signed_angle_to(direction_y, -x_axis)
			elif direction.z != 0 and direction.z > 0:
				angle1 = Vector3(0, 0, 1).signed_angle_to(direction_y, x_axis)
			elif direction.x != 0 and direction.x < 0:
				angle1 = Vector3(-1,0,0).signed_angle_to(direction_y, z_axis)
			elif direction.x != 0 and direction.x > 0:
				angle1 = Vector3(1,0,0).signed_angle_to(direction_y, -z_axis)
			rotate_object_local(x_axis, angle1)
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
