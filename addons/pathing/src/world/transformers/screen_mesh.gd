class_name MUP_World_Transformers_Screen_Mesh

var _mesh_picking : MUP_World_Mesh_Picking

func _init(mesh_picking : MUP_World_Mesh_Picking):
	_mesh_picking = mesh_picking
	

func transform(pos : Vector2) -> Vector3:
	var result = _mesh_picking.pick(pos)
	if !result.empty():
		return result["position"].floor()
	return Vector3.ZERO
