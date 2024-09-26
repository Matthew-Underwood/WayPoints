class_name MUT_Mesh_Transformer

var _mesh_data_tool : MeshDataTool
var _surface_tool : SurfaceTool


func _init(mesh_data_tool : MeshDataTool, surface_tool : SurfaceTool):
	_mesh_data_tool = mesh_data_tool
	_surface_tool = surface_tool


func update(instance_mesh : MeshInstance, vertices : Array, height : float) -> void:
	
	_surface_tool.create_from(instance_mesh.mesh, 0)
	var array_mesh = _surface_tool.commit()
	_mesh_data_tool.create_from_surface(array_mesh, 0)
	
	for v in range(_mesh_data_tool.get_vertex_count()):
		var pos = _mesh_data_tool.get_vertex(v)
		var global_pos = Vector2(instance_mesh.to_global(pos).x, instance_mesh.to_global(pos).z)
		if global_pos in vertices:
			_mesh_data_tool.set_vertex(v, Vector3(pos.x, height,  pos.z))

	array_mesh.surface_remove(0)
	_mesh_data_tool.commit_to_surface(array_mesh)
	instance_mesh.refresh_mesh(array_mesh)