class_name MUW_Transformers_Screen_Mesh

var _mesh_picking : MUW_Mesh_Picker

func _init(mesh_picking : MUW_Mesh_Picker):
	_mesh_picking = mesh_picking
	

func transform(pos : Vector2) -> Vector2:
	var result = _mesh_picking.pick(pos)
	if !result.empty():
		return Vector2(result["position"].x, result["position"].z).floor()
	return Vector2.ZERO
