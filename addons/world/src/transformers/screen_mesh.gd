class_name MUW_Transformers_Screen_Mesh

var _mesh_picking : MUW_Mesh_Picker

func _init(mesh_picking : MUW_Mesh_Picker):
	_mesh_picking = mesh_picking
	

func transform(pos : Vector2) -> Vector3:
	var result = _mesh_picking.pick(pos)
	if !result.empty():
		return result["position"].floor()
	return Vector3.ZERO
