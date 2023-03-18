class_name MUW_Line_Factory


func create(node, path : Array):
	
	var line_vertices = PoolVector3Array()
	var b = node.transform.basis
	var o = node.transform.origin
	
	for p in range(1, len(path)):
		var source = path[p - 1]
		var destination = path[p]
		var points = node.create_line(source, destination)
		line_vertices.append_array(points)
	
	print(line_vertices)
	node.transform.origin = o
	node.transform.basis = b
	
	var array_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = line_vertices
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	node.mesh = array_mesh
	var line_material = load("res://line.tres")
	node.set_surface_material(0, line_material)



	
	

